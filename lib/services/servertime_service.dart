import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfren_attendance/models/http/http_response_model.dart';
import 'package:smartfren_attendance/models/servertime/servertime_request_model.dart';
import 'package:smartfren_attendance/models/servertime/servertime_response_model.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/utils/http/client.dart';

class ServerTimeService with CacheManager {

  Future<dynamic> fetchServerTime({required ServerTimeRequestModel serverTimeRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/servertime',
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
        data: serverTimeRequestModel.toJson()
      );
      return ServerTimeResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

}