import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartfren_attendance/models/auth/signin_request_model.dart';
import 'package:smartfren_attendance/models/auth/signin_response_model.dart';
import 'package:smartfren_attendance/models/change_password/change_password_request_model.dart';
import 'package:smartfren_attendance/models/change_uuid/change_uuid_request_model.dart';
import 'package:smartfren_attendance/models/change_uuid/change_uuid_response_model.dart';
import 'package:smartfren_attendance/models/http/http_response_model.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/utils/http/client.dart';

class AuthService with CacheManager {

  Future<dynamic> fetchSignIn({required SignInRequestModel signInRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/signin',
        options: Options(
          headers: {
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"]
          }
        ),
        data: signInRequestModel.toJson());
      return SignInResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

  Future<dynamic> fetchChangePassword({required ChangePasswordRequestModel changePasswordRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/changepassword',
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
        data: changePasswordRequestModel.toJson()
      );
      return HttpResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

  Future<dynamic> fetchChangeUuid({required ChangeUuidRequestModel changeUuidRequestModel}) async {
    try {
      var dio = client();
      var headers = await getDeviceInfo();
      final response = await dio.post(
        '/changeuuid',
        options: Options(
          headers: {
            "Os": headers["os_platform"],
            "Os-Version": headers["os_version"],
            "Phone-Manufacture": headers["manufacture"],
            "Phone-Model": headers["model"],
            "App-Version": headers["app_version"]
          }
        ),
        data: changeUuidRequestModel.toJson()
      );
      return ChangeUuidResponseModel.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      } else {
        return HttpResponseModel(errCode: 999, success: false, message: e.response!.statusMessage);
      }
    }
  }

}