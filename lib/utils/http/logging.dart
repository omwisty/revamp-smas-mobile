import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class Logging extends Interceptor {
  var logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('REQUEST[${options.method}] => URI: ${options.uri}\nPATH: ${options.path}\nHEADERS : ${options.headers}\nPARAMS : ${options.queryParameters}\nPAYLOAD : ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}\n${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.e('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\n${err.response?.data}');
    return super.onError(err, handler);
  }
}