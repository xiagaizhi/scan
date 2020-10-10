import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/base/Application.dart';
import 'package:scan/router/Routes.dart';

import 'ConvertUtil.dart';

class NavigatorUtil {
  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  static void goHomePage(BuildContext context) {
    //replace 从栈中移除
    Application.router.navigateTo(context, Routes.main, replace: true);
  }
  static void go(BuildContext context,String routes) {
    //replace 从栈中移除
    Application.router.navigateTo(context, routes, replace: false);
  }

  // static void goPramPage(BuildContext context, String name, int age,
  //     double score, bool sex, Person person) {
  //   String cnName = ConvertUtil.encode(name);
  //   String personJson = ConvertUtil.object2string(person);
  //   Application.router.navigateTo(
  //       context,
  //       Routes.demoParams +
  //           "?name=$cnName&age=$age&score=$score&sex=$sex&personJson=$personJson");
  // }

  /// 跳转到 会返回参数的 页面
  static Future goReturnParamsPage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.returnPrams);
  }


  static Future gotransitionDemoPage(BuildContext context, String title) {
    return Application.router.navigateTo(
        context, Routes.transitionDemo + "?title=$title",
        /// 指定了 转场动画 inFromLeft
        transition: TransitionType.inFromLeft);
  }
}
