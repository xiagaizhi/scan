import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/utils/ConvertUtil.dart';
class RouteHandlers {
  static Handler normalHandler(Object page) {
    return new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return page;
    });
  }

  // static var paramHandler = new Handler(
  //     handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  //   String name = params["name"]?.first;
  //   String age = params["age"]?.first;
  //   String sex = params["sex"]?.first;
  //   String score = params["score"]?.first;
  //   String personJson = params['personJson']?.first;
  //
  //   /// 下面转换为真实想要的类型
  //   return DemoParamsPage(
  //     name: name,
  //     age: ConvertUtil.string2int(age),
  //     score: ConvertUtil.string2double(score),
  //     sex: ConvertUtil.string2bool(sex),
  //     personJson: personJson,
  //   );
  // });

  // static var returnPramsHandler =  new Handler(
  //     handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  //       return ReturnParamsPage();
  //     });
  // static var transitionDemoHandler = new Handler(
  //     handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  //       String title = params["title"]?.first;
  //       return TransitionDemoPage(title);
  //     });
}
