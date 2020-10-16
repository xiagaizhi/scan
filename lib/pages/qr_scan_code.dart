import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/router/Routes.dart';
import 'package:scan/utils/DeviceUtils.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/CommonUtil.dart';
import 'package:scan/utils/NavigatorUtil.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/utils/ShareUtils.dart';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan_plugin/call_back.dart';
import 'package:scan_plugin/data/scan_config_data.dart';
import 'package:scan_plugin/data/scan_result_data.dart';
import 'package:scan_plugin/scan_plugin.dart';
import 'package:scan/pages/login.dart';
import 'package:scan/network/ienv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scan/model/user_info_entity.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> with ICallBack {
  var title = "demo";

  @override
  void initState() {
    super.initState();

    DeviceUtils.getDeviceInfo();
    autoLogin();
    ScanPlugin.register(this);
  }

  ///自动登陆
  autoLogin() async {
    //获取登陆信息
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userStr = prefs.get(ShareUtils.userInfo);
    if (userStr == null || userStr == '') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Login();
      }));
      return;
    }
    UserInfoEntity user = new UserInfoEntity();
    user.fromJson(jsonDecode(userStr));
    print('userinfo:' + user.mobile);

    var param = {
      'client': 'supplier-app',
      'deviceName': DeviceUtils.androidDeviceInfo.model, //设备名称
      'deviceNo': DeviceUtils.androidDeviceInfo.androidId, //设备编号
      'imei': [DeviceUtils.androidDeviceInfo.androidId], //
      'meid': DeviceUtils.androidDeviceInfo.androidId, //设备id
      'sysName': DeviceUtils.androidDeviceInfo.device, //系统名称
      'sysNo': DeviceUtils.androidDeviceInfo.androidId, //系统编号
      'mobile': user.mobile, //手机号码
      'signCode': user.signCode, //设备登录签名
    };
    ResultData data = await HttpManager.getInstance(type: UrlType.sso)
        .post('/login/app/auto/v2', param);

    if (data.status != 'OK') {
      ToastUtils.showToast_1(data.errorMsg.toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Login();
      }));
      return;
    }
    UserInfoEntity userbean = new UserInfoEntity();
    userbean.fromJson(data.data);
    prefs.setString(ShareUtils.token, userbean.token);
    prefs.setString(ShareUtils.userInfo, jsonEncode(data.data));
  }

  @override
  void dispose() {
    super.dispose();
    ScanPlugin.remove(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('电子面单扫描',style: TextStyle(
          fontSize: 18
        ),),
        leading: InkWell(
          onTap: () {
            NavigatorUtil.go(context, Routes.noSendConfirm);
          },
          child: Container(
            alignment: Alignment.center,
            child: Image(
              width: 24,
              height: 24,
              image: AssetImage("assets/images/scan.png"),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              //跳转并关闭当前页面
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(builder: (context) => new Login()),
                (route) => route == null,
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 16),
              child: Image(
                width: 24,
                height: 24,
                image: AssetImage("assets/images/exit.png"),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
//              color: Colors.blue,
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          dense: true,
                          title: Text('不发货面单扫码'),
                          subtitle: Text("可用于标记各发货批次中现在“不发货”的订单"),
                          onTap: () {
                            scanNoSend(context);
                          }),
                    ],
                  ),
                )),
            Card(
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          dense: true,
                          title: Text('单个面单发货扫码'),
                          subtitle: Text("可用于单个面单的订单信息查询及发货操作"),
                          onTap: () {
                            scanSingleSend(context);
                          }),
                    ],
                  ),
                )),
            Card(
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          dense: true,
                          title: Text('失效面单扫描'),
                          subtitle: Text("可用于标记已失效面单"),
                          onTap: () {
                            scan(type: ScanType.ALL);
                          }),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future scanNoSend(BuildContext context) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: true,
        isNeedButton: true,
        buttonString: "扫码完毕",
        tipString: "提示",
        toastString: "扫码成功",
        formatType: -1);
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    if (!mounted) return;
    NavigatorUtil.go(context, Routes.noSendConfirm);
  }

  Future scanSingleSend(BuildContext context) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: false,
        isNeedButton: false,
        buttonString: "扫码完毕",
        tipString: "提示",
        toastString: "扫码成功",
        formatType: -1);
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    if (!mounted) return;
    NavigatorUtil.goPramPage(context, Routes.sendGoods, data);
  }

  Future scan({ScanType type = ScanType.QR}) async {
    ScanResultData data;
    ScanConfigData config = ScanConfigData(
        isSplashOn: true,
        isContinuous: true,
        isNeedButton: true,
        buttonString: "扫码完毕",
        tipString: "提示",
        toastString: "扫码成功",
        formatType: getQrFormat(type));
    try {
      print(config);
      print(json.encode(config));
      data = await ScanPlugin.startScan(config);
    } on PlatformException {
      print("Failed to get platform version.");
    }
    if (!mounted) return;

    setState(() {});
  }

  int getQrFormat(ScanType type) {
    switch (type) {
      case ScanType.QR:
        return 1;
      case ScanType.OTHER:
        return -1;
      case ScanType.ALL:
        return 0;
    }
    return 0;
  }

  @override
  void callBack(ScanResultData data) {
    PageUtil.handleScanEvent(data.data);
  }
}

enum ScanType { QR, OTHER, ALL }
