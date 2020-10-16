import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/base/Application.dart';
import 'package:scan/router/Routes.dart';
import 'package:scan_plugin/data/scan_result_data.dart';

import 'ConvertUtil.dart';

class NavigatorUtil {
  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }


  static void go(BuildContext context, String route, {bool replace = false}) {
    //replace 从栈中移除
    Application.router.navigateTo(context, route, replace: replace);
  }

  static void goPramPage(BuildContext context, String path, Object object) {
    String data = ConvertUtil.object2string(object);
    Application.router.navigateTo(context, path + "?data=$data");
  }


}
