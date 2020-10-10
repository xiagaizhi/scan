import 'package:dio/dio.dart';
import 'package:scan/platform/platform_log.dart';

class LogsInterceptor extends InterceptorsWrapper {
  static const String TAG = "LogsInterceptor";

  @override
  Future onRequest(RequestOptions options) {
    Log.i(TAG, "REQUEST[${options?.method}] => PATH: ${options?.baseUrl}${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    Log.i(TAG,
        "RESPONSE[${response?.data}] => PATH: ${response?.request?.path}");
    print(response);
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    Log.e(TAG,
        "ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}
