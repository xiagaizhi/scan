import 'package:dio/dio.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/response_interceptor.dart';
import 'package:scan/platform/platform_log.dart';
import 'package:scan/utils/ShareUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'ienv.dart';
import 'log_interceptor.dart';

class HttpManager {
  static HttpManager _instance;
  Dio _dio;

  HttpManager._internal()  {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
        baseUrl: Config.getBaseUrl(UrlType.normal),
        connectTimeout: 15000,
        headers: {
        },
      ));
      _dio.interceptors.add(new LogsInterceptor());
      _dio.interceptors.add(new ResponseInterceptor());
    }
  }

  factory HttpManager.getInstance({UrlType type}) => _getInstance(type);

  static _getInstance(UrlType type) {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return type == null
        ? _instance._resetBaseUrl()
        : _instance._setBaseUrl(type);
  }

  HttpManager _resetBaseUrl() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Config.getBaseUrl(UrlType.normal)) {
        _dio.options.baseUrl = Config.getBaseUrl(UrlType.normal);
      }
    }
    return _instance;
  }

  HttpManager _setBaseUrl(UrlType type) {
    if (_dio != null) {
      _dio.options.baseUrl = Config.getBaseUrl(type);
    }
    return _instance;
  }


  get(url, params) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      print(e);
      return e;
    }
    if (response.data is DioError) {
      return response.data['code'];
    }

    return response.data;
  }

  Future<ResultData> post(url, params) async {
    Response response;
    try {
      print("httpUrl:"+url +"----");
      print("params:"+params.toString());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.get(ShareUtils.token);
      if(token!=null&&token!=''){
        var map = Map();
        map['Authorization'] = token;
        _dio.options.headers.addAll(new Map<String,String>.from(map));
      }
      response = await _dio.post(url, data: params);

    } on DioError catch (e) {
      print(e);
    }
    print(response);
    return response.data;
  }
}
