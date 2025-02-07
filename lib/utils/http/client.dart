import 'package:dio/dio.dart';
import 'package:dio_interceptor_ui/dio_interceptor_ui.dart';
import 'package:smartfren_attendance/app_config.dart';
import 'package:smartfren_attendance/utils/http/logging.dart';

Dio client() {
  final flavour = AppConfig.env;
  var dio = Dio(
    BaseOptions(
      baseUrl: flavour.getEndpoint(),
      connectTimeout: 10000,
      receiveTimeout: 10000,
      followRedirects: false,
    ),
  );
  // dio.interceptors.add(Logging());
  // dio.interceptors.add(DioNetworkInterceptor());
  return dio;
}