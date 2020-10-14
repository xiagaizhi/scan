import 'package:dio/dio.dart';
import 'package:scan/platform/platform_log.dart';

class LogsInterceptor extends InterceptorsWrapper {
  static const String TAG = "LogsInterceptor";

  @override
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options?.method}] => PATH: ${options?.baseUrl}${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response?.data}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}
