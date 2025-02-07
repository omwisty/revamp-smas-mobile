import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfren_attendance/models/http/http_response_model.dart';
import 'package:smartfren_attendance/models/presence/presence_request_model.dart';
import 'package:smartfren_attendance/models/presence/presence_response_model.dart';
import 'package:smartfren_attendance/models/presence/report_request_model.dart';
import 'package:smartfren_attendance/models/presence/report_response_model.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/utils/http/client.dart';

class PresenceService with CacheManager {

  Future<dynamic> fetchPresence({required PresenceRequestModel presenceRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      var encryptedPayload = presenceRequestModel.toEncryptPayload(getAuthenticate()!['user_id'], headers['uuid']);
      final response = await dio.post(
        '/presence',
        options: Options(
          headers: {
            HttpHeaders.contentLengthHeader: "",
            HttpHeaders.contentTypeHeader: "text/plain",
            HttpHeaders.authorizationHeader: "Bearer ${getToken()}",
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"],
          }
        ),
        data: encryptedPayload
      );
      return PresenceResponseModel.fromJson(jsonDecode(response.data));
      // logger.d(encryptedPayload);
      // return PresenceResponseModel.fromJson({
      //   "success": true
      // });
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

  Future<dynamic> fetchRetrieveReport({required ReportRequestModel reportRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/report',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${getToken()}",
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"]
          }
        ),
        data: reportRequestModel.toJson()
      );
      return ReportResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

}