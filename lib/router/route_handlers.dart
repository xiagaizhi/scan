import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scan/pages/edit_no_send_order.dart';
import 'package:scan/pages/send_goods.dart';

class RouteHandlers {
  static Handler normalHandler(Object page) {
    return new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return page;
    });
  }

  static var sendGoodsHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    String data = params["data"]?.first;

    /// 下面转换为真实想要的类型
    return SendGoodsPage(
      data: data,
    );
  });
  static var editNoSendHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        String data = params["data"]?.first;

        /// 下面转换为真实想要的类型
        return EditNoSendPage(
          scanResult: data,
        );
      });

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
