import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/pages/failure_order_page.dart';
import 'package:scan/pages/qr_scan_code.dart';
import 'package:scan/pages/no_send_order_page.dart';
import 'package:scan/router/route_handlers.dart';

class Routes {
  static String root = "/";
  static String noSendConfirm = "/noSendConfirm";
  static String sendGoods = "/sendGoods";
  static String failureOrder = "/failureOrder";
  static String main = "/main";
  static String home = "/home";
  static String information = "/information";
  static String service = "/service";
  static String find = "/find";
  static String mine = "/mine";
  static String demoParams = "/params";
  static String returnPrams = "/return_prams";
  static String transitionDemo = "/transitionDemo";
  static String listRefresh = "/listRefresh";
  static String listPage = "/listPage";
  static String gridPage = "/gridPage";
  static String sliverListPage = "/sliverListPage";
  static String sliverGridPage = "/sliverGridPage";

  static void configureRoutes(Router router) {
    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    router.define(root, handler: RouteHandlers.normalHandler(new QRCodePage()));
    router.define(noSendConfirm,
        handler: RouteHandlers.normalHandler(new NoSendOrderPage()));
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
