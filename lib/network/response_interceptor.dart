import 'package:dio/dio.dart';
import 'package:scan/model/result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      ResultData data = new ResultData();
      data.fromJson(response.data);
      response.data = data;
    }
    return super.onResponse(response);
  }
}