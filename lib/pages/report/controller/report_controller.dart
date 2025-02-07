import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:smartfren_attendance/models/presence/report_request_model.dart';
import 'package:smartfren_attendance/services/presence_service.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';

class ReportController extends GetxController {
  var logger = Logger();
  final formGlobalKey = GlobalKey<FormBuilderState>();
  final _presenceService = Get.put(PresenceService());
  RxBool isLoading = false.obs;
  RxList filter = [].obs;
  RxString startDate = "".obs;
  RxString endDate = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  onGenerateReport() async {
    filter.value = [];
    var startDate = DateFormat("yyyy-MM-dd").format(formGlobalKey.currentState?.value['start_date']).toString();
    var endDate = DateFormat("yyyy-MM-dd").format(formGlobalKey.currentState?.value['end_date']).toString();
    bool isMax = isMaxAMonth(startDate.toString(), endDate.toString());
    if(isMax) {
      SnackBarWidget(
        title: "Maximum Log",
        message: "Maximum generate log is 30 days",
        type: SnackBarType.warning
      ).show();
    } else {
      isLoading.value = true;
      ReportRequestModel reportRequestModel = ReportRequestModel(
          dateFrom: startDate.toString(),
          dateTo: endDate.toString()
      );
      final response = await _presenceService.fetchRetrieveReport(reportRequestModel: reportRequestModel);
      if (response.errCode == 0 && response.data != null) {
        List data = response.data;
        for(var item in data){
          var adr = await getAddress(double.parse(item['latitude']), double.parse(item['longitude']));
          Map<String, dynamic> i = {
            "presenceDate": item['presence_date'],
            "date": item['date'],
            "latitude": double.parse(item['latitude']),
            "longitude": double.parse(item['longitude']),
            "presenceFlag": int.parse(item['presence_flag']),
            "address": adr.toString()
          };
          filter.add(i);
        }
        isLoading.value = false;
        formGlobalKey.currentState?.reset();
        Get.toNamed("/report-list");
      } else {
        isLoading.value = false;
        SnackBarWidget(
          title: "Invalid Generate Report",
          message: "Invalid to retrieve presence report",
          type: SnackBarType.error
        ).show();
      }
    }
  }

  Future<String> getAddress(double? lat, double? long) async {
    if (lat == null || long == null) return "";
    List<Placemark> adr = await placemarkFromCoordinates(lat, long);
    var name = adr[0].name != null ? '${adr[0].name}, ' : '';
    var administrativeArea = adr[0].administrativeArea != null ? '${adr[0].administrativeArea}, ' : '';
    var subLocality = adr[0].subLocality != null ? '${adr[0].subLocality}, ' : '';
    var locality = adr[0].locality != null ? '${adr[0].locality}' : '';
    return '$name$administrativeArea$subLocality$locality';
  }

  bool isMaxAMonth(String startDate, String endDate) {
    String datePattern = "yyyy-MM-dd";
    DateTime x = DateFormat(datePattern).parse(startDate);
    DateTime y = DateFormat(datePattern).parse(endDate);
    final difference = y.difference(x).inDays;
    return difference > 30;
  }

  onChangeDate(date) {
    String datePattern = "yyyy-MM-dd";
    DateTime x = DateFormat(datePattern).parse(date.toString());
    endDate.value = x.add(const Duration(days: 30)).toString();
    formGlobalKey.currentState?.fields['end_date']?.didChange(x.add(const Duration(days: 30)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}