import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan/constants/ienv.dart';
import 'package:scan/constants/string_constant.dart';
import 'package:scan/model/express_data_entity.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/router/Routes.dart';
import 'package:scan/sql/failure_order_table.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan_plugin/constants/string_constant.dart';
import 'package:scan_plugin/data/scan_config_data.dart';
import 'package:scan_plugin/data/scan_result_data.dart';
import 'package:scan_plugin/scan_plugin.dart';

import 'NavigatorUtil.dart';

class PageUtil {
  static handleScanEvent(ScanResultData data) async {
    switch (data.pageType) {
      case StringConstant.PAGE_NO_SEND:
        handleNoSendOrder(data.data);
        break;
      case StringConstant.PAGE_FAILURE:
        handleFailureOrder();
        break;
    }

    ScanPlugin.restartScan();
  }

  static handleNoSendOrder(String expressId) async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics).post(
            "/admin/print-task-item/get-base-order-by-express",
            {"expressNo": expressId});
    OrderTable orderTable = OrderTable();
    if (resultData.data == null) {
      ToastUtils.showToast_1(resultData.errorMsg);
      return;
    }
    if (resultData.isSuccess()) {
      for (Map<String, dynamic> map in resultData.data) {
        OrderData orderData = OrderData();
        orderData.fromJson(map);
        await SqlHelper.insert(orderTable, orderData.toJson());
      }
    } else {
      ToastUtils.showToast_1(resultData.errorMsg);
    }
  }

  static handleFailureOrder() async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics)
            .post("/admin/eorder-using/get-eorder-base-info", {
      "expressNo": "111114540522",
      "status": [1, 3],
      "expressStatus": [0]
    });
    FailureOrderTable orderTable = FailureOrderTable();

    if (resultData.data == null) {
      ToastUtils.showToast_1(resultData.errorMsg);
      return;
    }
    if (resultData.isSuccess()) {
      for (Map<String, dynamic> map in resultData.data) {
        ExpressData expressData = ExpressData();
        expressData.fromJson(map);
        expressData.needDeliver = 1;
        await SqlHelper.insert(orderTable, expressData.toJson());
      }
    } else {
      ToastUtils.showToast_1(resultData.errorMsg);
    }
  }

  static Future scanNoSend(BuildContext context, bool newPage) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: true,
        isNeedButton: true,
        buttonString: "扫码完毕",
        tipString: Constants.SCAN_NO_SEND_TIP,
        toastString: "扫码成功",
        pageType: StringConstant.PAGE_NO_SEND,
        formatType: -1);
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    if (newPage) {
      NavigatorUtil.go(context, Routes.noSendConfirm);
    }
  }

  static Future scaFailureBarCode(BuildContext context, bool newPage) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: true,
        isNeedButton: true,
        buttonString: "扫码完毕",
        tipString: Constants.SCAN_FAILURE_TIP,
        toastString: "扫码成功",
        pageType: StringConstant.PAGE_FAILURE,
        formatType: -1);
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    if (newPage) {
      NavigatorUtil.go(context, Routes.failureOrder);
    }
  }

  static Future scanSingleSend(BuildContext context) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: false,
        isNeedButton: false,
        buttonString: "扫码完毕",
        tipString: "提示",
        toastString: "扫码成功",
        pageType: StringConstant.PAGE_SINGLE_SEND,
        formatType: -1);
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    NavigatorUtil.goPramPage(context, Routes.sendGoods, data);
  }
}
