import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartfren_attendance/models/handset/check_handset_request_model.dart';
import 'package:smartfren_attendance/services/check_handset_service.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';

class InitController extends GetxController {
  final _authManager = Get.put(AuthManager());
  final _httpCheck = Get.put(CheckHandsetService());

  RxMap device = {}.obs;
  RxBool isValidHandset = false.obs;
  RxBool needUpdate = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _checkPermission();
    var deviceInfo = await getDeviceInfo();
    device.addAll(deviceInfo);
    checkHandset();
    _authManager.checkLogin();
    _authManager.onRootDetection();
  }

  void _checkPermission() async {
    await [
      Permission.location,
    ].request();
  }

  checkHandset() async {
    CheckHandsetRequestModel checkHandsetRequestModel = CheckHandsetRequestModel(
      platform: Platform.isAndroid ? "Android" : "iOS",
      imsi: "null",
      imei: "null",
      uuid: device['uuid'],
      // uuid: "27a13e9fd8bef032",
      // uuid: "f5258fb7d6e6d797"
    );
    final response = await _httpCheck.fetchCheckHandset(checkHandsetRequestModel: checkHandsetRequestModel);
    if (response.errCode == 0) {
      isValidHandset.value = response.isValidHandset;
      needUpdate.value = response.needUpdate;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}