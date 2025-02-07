import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartfren_attendance/models/handset/check_handset_request_model.dart';
import 'package:smartfren_attendance/models/handset/check_handset_response_model.dart';
import 'package:smartfren_attendance/models/http/http_response_model.dart';
import 'package:smartfren_attendance/models/updates/updates_request_model.dart';
import 'package:smartfren_attendance/models/updates/updates_response_model.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/utils/http/client.dart';

class CheckHandsetService with CacheManager {

  Future<dynamic> fetchCheckHandset({required CheckHandsetRequestModel checkHandsetRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/checkhandset',
        options: Options(
          headers: {
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"]
          }
        ),
        data: checkHandsetRequestModel.toJson());
      return CheckHandsetResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

  Future<dynamic> fetchNewUpdateLink({required UpdatesRequestModel updatesRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/update',
        options: Options(
          headers: {
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"]
          }
        ),
        data: updatesRequestModel.toJson());
      return UpdatesResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }
  
  Future<dynamic> downloadNewApp() async {
    try {
      var dio = client();
      String savePath = await getFilePath('test.apk');
      await dio.download("https://myhr.smartfren.com/sap/public/bc/icons/smas/dl/SMAS_v10.apk", savePath);
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName.apk';
    return path;
  }

}