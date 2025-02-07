import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:smartfren_attendance/constant.dart';
import 'package:smartfren_attendance/models/presence/presence_model.dart';
import 'package:smartfren_attendance/models/presence/presence_request_model.dart';
import 'package:smartfren_attendance/models/servertime/servertime_request_model.dart';
import 'package:smartfren_attendance/pages/profile/controller/profile_controller.dart';
import 'package:smartfren_attendance/services/presence_service.dart';
import 'package:smartfren_attendance/services/servertime_service.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/date/date.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';
import 'package:trust_location/trust_location.dart';

class AttendanceController extends GetxController with CacheManager {
  var logger = Logger();
  late BuildContext context;
  final _httpServerTime = Get.put(ServerTimeService());
  final _httpPresence = Get.put(PresenceService());
  RxString clock = "".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString location = "Loading...".obs;
  RxString address = "Loading Address...".obs;
  RxString nik = "".obs;
  RxString serverTime = "".obs;
  RxBool isMockLocation = false.obs;
  RxString distanceInfo = "0 km".obs;
  RxList officeCoords = [].obs;
  RxBool isCheckInLoading = false.obs;
  RxBool isCheckOutLoading = false.obs;
  RxString lastStatus = "-".obs;
  RxMap lastPresence = {}.obs;
  RxBool isRefreshLocation = false.obs;
  late StreamSubscription<Position> positionStream;

  @override
  void onInit() {
    super.onInit();
    context = Get.context!;

    if(Platform.isAndroid) {
      TrustLocation.start(5);
    }

    getStaticLocation();
    getListenLocation();
    onLoadUser();
    getLastStatus();

    setTimer();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setTimer());
  }

  onLoadUser() {
    nik.value = '${getAuthenticate()!['user_id'] ?? ""}';
  }

  setTimer() {
    clock.value = timeString();
    update();
  }

  getServerTime(double latitude, double longitude) async {
    ServerTimeRequestModel serverTimeRequestModel = ServerTimeRequestModel(latitude: latitude, longitude: longitude);
    final response = await _httpServerTime.fetchServerTime(serverTimeRequestModel: serverTimeRequestModel);
    if (response.errCode == 0) {
      serverTime.value = response.serverTime;
    } else {
      final _profileController = Get.put(ProfileController());
      SnackBarWidget(title: "Error", message: response.message, type: SnackBarType.error).show();
      _profileController.onSubmitSignOut();
    }
  }

  getStaticLocation() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      if(Platform.isAndroid) {
        List<String?> position = await TrustLocation.getLatLong;
        getServerTime(double.parse(position[0].toString()), double.parse(position[1].toString()));
      } else if (Platform.isIOS) {
      //   None
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text("Please turn on location (GPS) settings."),
          actions: <Widget>[
            TextButton(
              onPressed: () => openSettings(),
              child: const Text('SETTINGS'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'CLOSE'),
              child: const Text('CLOSE'),
            ),
          ],
        ),
      );
    }
  }

  getListenLocation() async {
    isRefreshLocation.value = true;
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      if(Platform.isAndroid) {
        TrustLocation.onChange.listen((value) {
          String? lat = value.latitude;
          String? long = value.longitude;
          latitude.value = lat != null ? double.parse(lat) : 0.0;
          longitude.value = long != null ? double.parse(long) : 0.0;
          isMockLocation.value = value.isMockLocation!;
          if (lat != null && long != null) {
            getAddress(double.parse(lat), double.parse(long));
            isRefreshLocation.value = false;
          }
        });
      } else if(Platform.isIOS) {
        const LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
        positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings).listen((Position? position) {
            String? lat = position?.latitude.toString();
            String? long = position?.longitude.toString();
            latitude.value = lat != null ? double.parse(lat) : 0.0;
            longitude.value = long != null ? double.parse(long) : 0.0;
            if (lat != null && long != null) {
              getAddress(double.parse(lat), double.parse(long));
              isRefreshLocation.value = false;
            }
          });
      }
    } else {
      // SystemNavigator.pop();
    }
  }

  getAddress(double? lat, double? long) async {
    if (lat == null || long == null) return "";
    List<Placemark> adr = await placemarkFromCoordinates(lat, long);
    location.value = '${adr[0].locality}, ${adr[0].subAdministrativeArea}';
    address.value = '${adr[0].street}, ${adr[0].subLocality}, ${adr[0].locality}, ${adr[0].subAdministrativeArea}, ${adr[0].administrativeArea}, ${adr[0].country}, ${adr[0].postalCode}';
  }

  getDistance(double officeLat, double officeLong, int maxDistance) async {
    double distance = Geolocator.distanceBetween(latitude.value, longitude.value, officeLat, officeLong);
    officeCoords.add(distance);
  }

  onPresence(int flag) async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled) {
      if (flag == 10) {
        isCheckInLoading.value = true;
      } else if (flag == 20) {
        isCheckOutLoading.value = true;
      }
      officeCoords.value = [];
      var version = await getVersion();
      await getServerTime(latitude.value, longitude.value);

      var keyword = "12345678s";
      var accuracy = 22.756000518798828;
      var bytes = utf8.encode("${isMockLocation.value}${latitude.value}${longitude.value}${serverTime.value}${flag}");
      var digest = sha1.convert(bytes);
      PresenceRequestModel presenceRequestModel = PresenceRequestModel(
        keyword: keyword,
        presenceDate: serverTime.value,
        latitude: latitude.value,
        longitude: longitude.value,
        accuracy: accuracy,
        isMockLocation: isMockLocation.value,
        presenceFlag: flag,
        checksum: "$digest",
        version: version
      );
      final response = await _httpPresence.fetchPresence(presenceRequestModel: presenceRequestModel);
      if (response.errCode == 0) {
        var box = await Hive.openBox<PresenceModel>(presenceBox);
        PresenceModel presenceModel = PresenceModel(
            id: box.length + 1,
            keyword: keyword,
            presenceDate: serverTime.value,
            latitude: latitude.value,
            longitude: longitude.value,
            accuracy: accuracy,
            isMockLocation: isMockLocation.value,
            presenceFlag: flag,
            checksum: "$digest}",
            version: version,
            date: DateFormat("yyyy-MM-dd").format(DateTime.parse(serverTime.value))
        );
        box.add(presenceModel).then((value) {
          var msg = response.message.toString().replaceAll("<br />", "\n");
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Success'),
                  content: Text(msg),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'CLOSE'),
                      child: const Text('CLOSE'),
                    ),
                  ],
                ),
          );
        });
      } else if (response.errCode == 999) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Warning'),
              content: Text(response.message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'CLOSE'),
                  child: const Text('CLOSE'),
                ),
              ],
            ),
        );
      } else {
        for (var i in response.officeLocations) {
          getDistance(i['latitude'], i['longitude'], response.maxRadius);
        }
        officeCoords.sort();
        distanceInfo.value = "${(officeCoords.first / 1000).toStringAsFixed(2)} km";
        SnackBarWidget(
          title: "Warning",
          message: "${response.message}\nYour distance from office is ${distanceInfo.value}",
          type: SnackBarType.warning)
        .show();
      }
      if (flag == 10) {
        isCheckInLoading.value = false;
      } else if (flag == 20) {
        isCheckOutLoading.value = false;
      }
      getLastStatus();
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text("Please turn on location (GPS) settings."),
          actions: <Widget>[
            TextButton(
              onPressed: () => openSettings(),
              child: const Text('SETTINGS'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'CLOSE'),
              child: const Text('CLOSE'),
            ),
          ],
        ),
      );
    }
  }

  getLastStatus() async {
    var box = await Hive.openBox<PresenceModel>(presenceBox);
    List data = box.values.toList();
    if(data.isNotEmpty) {
      data.sort((a, b) => b.presenceDate!.compareTo(a.presenceDate!));

      var timeIn = data.first.presenceFlag == 10 ? "${dateHumanFormat(DateTime.parse(data.first.presenceDate))} ${timeFormat(DateTime.parse(data.first.presenceDate))}" : "-";
      var timeOut = data.first.presenceFlag == 20 ? "${dateHumanFormat(DateTime.parse(data.first.presenceDate))} ${timeFormat(DateTime.parse(data.first.presenceDate))}" : "-";
      if(data.first.presenceFlag == 20) {
        var searchIn = data.where((element) => element.date == data.first.date).toList();
        var isCheckIn = searchIn.where((element) => element.presenceFlag == 10).first;
        timeIn = "${dateHumanFormat(DateTime.parse(isCheckIn.presenceDate))} ${timeFormat(DateTime.parse(isCheckIn.presenceDate))}";
      }
      Map<String, dynamic> last = {
        "time_in": timeIn,
        "time_out": timeOut,
      };
      lastPresence.value = last;
      lastStatus.value = data.first.presenceFlag == 10 ? "Check In" : "Check Out";
    }
  }

  refreshLocation() async {
    if(Platform.isIOS) {
      positionStream.cancel();
      await getListenLocation();
    } else if(Platform.isAndroid) {
      await getListenLocation();
    }
  }

  openSettings() async {
    var openLocation = await Geolocator.openLocationSettings();
    if (openLocation) {
      Navigator.pop(context);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Info'),
          content: const Text("Please click Refresh Location to update"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                getListenLocation();
                Navigator.pop(context);
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
