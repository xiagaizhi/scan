import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scan/constants/config.dart';
import 'package:scan/constants/ienv.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/router/Routes.dart';
import 'package:scan/utils/DeviceUtils.dart';
import 'package:scan/utils/NavigatorUtil.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/utils/ShareUtils.dart';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan_plugin/call_back.dart';
import 'package:scan_plugin/data/scan_result_data.dart';
import 'package:scan_plugin/scan_plugin.dart';
import 'package:scan/pages/login.dart';
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
      NavigatorUtil.go(context, Routes.login, replace: true);
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
      NavigatorUtil.go(context, Routes.login, replace: true);
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
  Timer _timer;
  double _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            child: new Text(
              '电子面单扫描',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text(''),
                      content: Text('确定切换访问地址'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('dev'),
                          onPressed: () {
                            Navigator.of(context).pop('ok');
                            Config.conStr = 'DEV';
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('qa'),
                          onPressed: () {
                            Navigator.of(context).pop('ok');
                            Config.conStr = 'QA';
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('pre'),
                          onPressed: () {
                            Navigator.of(context).pop('ok');
                            Config.conStr = 'PRE';
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('prod'),
                          onPressed: () {
                            Navigator.of(context).pop('ok');
                            Config.conStr = 'PROD';
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          leading: InkWell(
            onTap: () {
              PageUtil.scanQrCode(context, true);
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
                NavigatorUtil.go(context, Routes.login, replace: true);
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 10,
                  margin: EdgeInsets.all(6),
                  child: Container(
                    height: 160.0,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: Container(
                            width: 6,
                            height: 40,
                            color: Color.fromRGBO(243, 119, 109, 1),
                            child: Text(''),
                          ),
                        ),
                        Container(
                          width: 220,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 160,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 40),
                                child: Text('可用于标记各发货批次中现在“不发货”的订单'),
                              ),
                              Container(
                                  width: 160,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 8),
                                  child: ButtonTheme(
                                    minWidth: 145.0, //设置最小宽度
                                    height: 32.0,
                                    child: RaisedButton(
                                      color: Color.fromRGBO(243, 119, 109, 1),
                                      textColor: Colors.white,
                                      child: Text('不发货面单扫码'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      onPressed: () {},
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 100,
                            child: Image(
                              width: 100,
                              height: 100,
                              image: AssetImage("assets/images/bufahuo.png"),
                            ),
                          ),
                          onTap: () {
                            PageUtil.scanNoSend(context, true);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  margin: EdgeInsets.all(6),
                  child: Container(
                    height: 160.0,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: Container(
                            width: 6,
                            height: 40,
                            color: Color.fromRGBO(37, 135, 235, 1),
                            child: Text(''),
                          ),
                        ),
                        Container(
                          width: 220,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 160,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 40),
                                child: Text('可用于单个面单的订单信息查询及发货操作'),
                              ),
                              Container(
                                  width: 160,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 8),
                                  child: ButtonTheme(
                                    minWidth: 145.0, //设置最小宽度
                                    height: 32.0,
                                    child: RaisedButton(
                                      color: Color.fromRGBO(37, 135, 235, 1),
                                      textColor: Colors.white,
                                      child: Text('单个面单发货扫码'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      onPressed: () {},
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 100,
                            child: Image(
                              width: 100,
                              height: 100,
                              image: AssetImage("assets/images/fahuo.png"),
                            ),
                          ),
                          onTap: () {
                            PageUtil.scanSingleSend(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  margin: EdgeInsets.all(6),
                  child: Container(
                    height: 160.0,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: Container(
                            width: 6,
                            height: 40,
                            color: Color.fromRGBO(245, 157, 51, 1),
                            child: Text(''),
                          ),
                        ),
                        Container(
                          width: 220,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 160,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 40),
                                child: Text('可用于标记已失效面单'),
                              ),
                              Container(
                                  width: 160,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 8),
                                  child: ButtonTheme(
                                    minWidth: 145.0, //设置最小宽度
                                    height: 32.0,
                                    child: RaisedButton(
                                      color: Color.fromRGBO(245, 157, 51, 1),
                                      textColor: Colors.white,
                                      child: Text('失效面单扫描'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      onPressed: () {},
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 100,
                            child: Image(
                              width: 100,
                              height: 100,
                              image: AssetImage("assets/images/shixiao.png"),
                            ),
                          ),
                          onTap: () {
                            PageUtil.scaFailureBarCode(context, true);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void callBack(ScanResultData data) {
    PageUtil.handleScanEvent(data);
  }
}
