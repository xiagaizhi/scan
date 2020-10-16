import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/pages/failure_order_page.dart';
import 'package:scan/pages/login.dart';
import 'package:scan/pages/qr_scan_code.dart';
import 'package:scan/pages/no_send_confirm.dart';
import 'package:scan/router/route_handlers.dart';

class Routes {
  static String root = "/";
  static String noSendConfirm = "/noSendConfirm";
  static String login = "/login";
  static String sendGoods = "/sendGoods";
  static String failureOrder = "/failureOrder";

  static void configureRoutes(Router router) {
    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    router.define(root, handler: RouteHandlers.normalHandler(new QRCodePage()));
    router.define(login, handler: RouteHandlers.normalHandler(new Login()));
    router.define(noSendConfirm,
        handler: RouteHandlers.normalHandler(new NoSendConFirmPage()));
    router.define(sendGoods, handler: RouteHandlers.sendGoodsHandler);
    router.define(failureOrder,
        handler: RouteHandlers.normalHandler(new FailureOrderPage()));
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return Text("bull");
    });
  }
}
