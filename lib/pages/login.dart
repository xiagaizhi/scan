import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan/constants/ienv.dart';
import 'package:scan/model/code_entity.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/pages/qr_scan_code.dart';
import 'package:scan/utils/DeviceUtils.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan/model/secret_entity.dart';
import 'package:scan/utils/RSAUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scan/utils/ShareUtils.dart';
import 'package:scan/model/user_info_entity.dart';

/// 不发货面单结果

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
//焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  FocusNode _focusNodeCode = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _imgCodealue = new TextEditingController();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _passwordController = new TextEditingController();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _phoneCodeController = new TextEditingController();

//表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
  var _phoneCode = ''; //验证码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮
  var _isLoginWay = true; //判断是 密码登陆还是验证码登陆
  var _isCode = true; //判断是否显示倒计时
  var _codeText = "获取验证码";
  int _codeNumber = 10;
  Timer t;
  //倒计时
  _showTimer() {

    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this._codeNumber--;
        print("_codeNumber" + this._codeNumber.toString());
      });
      if (this._codeNumber == 0) {
        t.cancel(); //清除定时器
        setState(() {
          this._isCode = true;
          this._codeNumber = 10;
          this._codeText = "重新发送验证码";
        });
      }
    });
  }

  //清空登陆信息
  clean() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(ShareUtils.token); //删除指定键
    prefs.remove(ShareUtils.userInfo); //删除指定键
    prefs.clear();//清空键值对
  }

  @override
  void initState() {
    // TODO: implement initState
    clean();
    getSecretKey();

    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    _focusNodeCode.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _focusNodeCode.removeListener(_focusNodeListener);
    _userNameController.dispose();
    _imgCodealue.dispose();
    _passwordController.dispose();
    _phoneCodeController.dispose();
    if(t!=null){
      t.cancel(); //清除定时器
    }
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  /**
   * 验证用户名
   */
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  /**
   * 验证密码
   */
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  //图形验证码
  CodeBeanData imgCode;
  Uint8List imgBytes;

  //短信验证码
  CodeBeanData msgCode;

  //获取到的key
  SecretEntity mSecret;

  /// 获取图形验证码
  getImgCode() async {
    ResultData data = await HttpManager.getInstance(type: UrlType.sso)
        .post('/verify-code/get', {'type': 'NUMBER_IMG_CAPTCHA'});

    print(data.status);
    if (data.status != 'OK') {
      ToastUtils.showToast_1(data.errorMsg.toString());
      return;
    }
    imgCode = new CodeBeanData();
    imgCode.fromJson(data.data);
    setState(() {
      var bytes =
          imgCode.value.split(',')[1]; //'iVBORw0KGgoAAAANSUhEUg.....' 正确格式
      imgBytes = Base64Decoder().convert(bytes);
      _phoneCodeController.clear();
      _imgCodealue.clear();
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return Scaffold(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                body: CupertinoAlertDialog(
                  title: Text(
                    '请输入图片验证码',
                    style: TextStyle(fontSize: 16),
                  ),
                  content: SizedBox(
                      width: 230.0,
                      height: 90.0,
                      child: Column(
                        children: <Widget>[
                          new SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 105.0,
                                height: 80.0,
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 105.0,
                                      height: 46.0,
                                      margin: EdgeInsets.all(0),
                                      child: imgBytes != null
                                          ? new Image.memory(imgBytes)
                                          : Text('重新获取'),
                                    ),
                                    Container(
                                      height: 30.0,
                                      width: 105.0,
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        child: Text(
                                          "换一换",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            Navigator.of(context).pop('cancel');
                                            this.getImgCode();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 105.0,
                                height: 56.0,
                                alignment: Alignment.bottomCenter,
                                child: new TextFormField(
                                  controller: _imgCodealue,
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0.0, left: 20.0, bottom: 0.0),
                                    hintText: "输入字符",
                                    enabledBorder: OutlineInputBorder(
                                      //未选中时候的颜色
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue[400]),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      //选中时外边框颜色
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue[400]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop('cancel');
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('确认'),
                      onPressed: () {
                        if(_imgCodealue.text.length!=4){
                          ToastUtils.showToast_1('请输入图片验证码');
                          return;
                        }
                        Navigator.of(context).pop('ok');
                        if (_isCode) {
                          getCode();
                        }
                      },
                    ),
                  ],
                ));
          });
    });
  }

  /// 获取手机验证码
  getCode() async {
    var param = {
      "mobile": this._userNameController.text,
      "vcKey": imgCode.key,
      "vcValue": _imgCodealue.text
    };

    ResultData data = await HttpManager.getInstance(type: UrlType.sso).post(
        '/verify-code/get', {'param': param, 'type': 'SMS_VERIFY_CODE_V2'});
    print(data.status);
    if (data.status != 'OK') {
      ToastUtils.showToast_1(data.errorMsg.toString());
      return;
    }
    this._showTimer();
    _isCode = false;
    msgCode = new CodeBeanData();
    msgCode.fromJson(data.data);
  }

  /// 获取秘钥
  getSecretKey() async {
    ResultData data = await HttpManager.getInstance(type: UrlType.sso)
        .post('/secret-key/get', {});
    print(data.status);
    if (data.status != 'OK') {
      ToastUtils.showToast_1(data.errorMsg.toString());
      return;
    }
    mSecret = new SecretEntity();
    mSecret.fromJson(data.data);

    print("");
  }



  /// 调用登陆接口 --
  login() async {
    if (_isLoginWay) {
      loginPas();
    } else {
      loginCode();
    }
  }

  //账号密码登陆
  loginPas() async {
    String encode = await RSAUtils.encodeString1(
        this._passwordController.text, mSecret.publicKey);

    print("加密字符串---:$encode");
    var param = {
      'client': 'supplier-app', //登陆客户端
      'deviceName': DeviceUtils.androidDeviceInfo.model, //设备名称
      'deviceNo': DeviceUtils.androidDeviceInfo.androidId, //设备编号
      'imei': ['1235648595262546'], //
      'keyId': mSecret.keyId,
      'meid': DeviceUtils.androidDeviceInfo.androidId, //设备id
      'mobile': this._userNameController.text, //手机号码
      'password': encode,
      'sysName': DeviceUtils.androidDeviceInfo.device, //系统名称
      'sysNo': DeviceUtils.androidDeviceInfo.androidId, //系统编号
    };
    ResultData data = await HttpManager.getInstance(type: UrlType.sso)
        .post('/login/app/password/v2', param);
    print("data" + data.status);
    if(data.status != 'OK'){
      ToastUtils.showToast_1(data.errorMsg.toString());
      return;
    }
    UserInfoEntity user = new UserInfoEntity();
    user.fromJson(data.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ShareUtils.token, user.token);
    prefs.setString(ShareUtils.userInfo, jsonEncode(data.data));

    //跳转并关闭当前页面
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => new QRCodePage()),
          (route) => route == null,
    );
  }

  //验证码登陆
  loginCode() async {
    var param = {
      'client': 'supplier-app',
      'deviceName': DeviceUtils.androidDeviceInfo.model, //设备名称
      'deviceNo': DeviceUtils.androidDeviceInfo.androidId, //设备编号
      'imei': [DeviceUtils.androidDeviceInfo.androidId], //
      'meid': DeviceUtils.androidDeviceInfo.androidId, //设备id
      'mobile': this._userNameController.text, //手机号码
      'sysName': DeviceUtils.androidDeviceInfo.device, //系统名称
      'sysNo': DeviceUtils.androidDeviceInfo.androidId, //系统编号
      "vcKey": msgCode.key,
      "vcCode": _phoneCodeController.text,
      'verifyCodeType': 'SMS_VERIFY_CODE_V2'
    };
    ResultData data = await HttpManager.getInstance(type: UrlType.sso)
        .post('/login/app/sms/v2', param);

    if(data.status != 'OK'){
      ToastUtils.showToast_1(data.errorMsg.toString());
      return;
    }
    UserInfoEntity user = new UserInfoEntity();
    user.fromJson(data.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ShareUtils.token, user.token);
    prefs.setString(ShareUtils.userInfo, jsonEncode(data.data));

    //跳转并关闭当前页面
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => new QRCodePage()),
          (route) => route == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    ///密码登陆  验证码登陆
    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 70, left: 80),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text(
              "密码登陆",
              style: TextStyle(
                color: _isLoginWay ? Colors.blue[400] : Colors.grey,
                fontSize: 16.0,
              ),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: () {
              setState(() {
                _isLoginWay = true;
              });
            },
          ),
          ///垂直分割线
          SizedBox(
            width: 1,
            height: 14,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
          FlatButton(
            child: Text(
              "验证码登陆",
              style: TextStyle(
                color: !_isLoginWay ? Colors.blue[400] : Colors.grey,
                fontSize: 16.0,
              ),
            ),
            //点击快速注册、执行事件
            onPressed: () {
              setState(() {
                _isLoginWay = false;
              });
            },
          )
        ],
      ),
    );

    ///输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 50, right: 50),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 260),
              child: new TextFormField(
                controller: _userNameController,
                focusNode: _focusNodeUserName,
                //设置键盘类型
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "手机号",
                  hintText: "请输入手机号",
                  //尾部添加清除按钮
                  suffixIcon: (_isShowClear)
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            // 清空输入框内容
                            _userNameController.clear();
                          },
                        )
                      : null,
                ),
                //验证用户名
                validator: validateUserName,
                //保存数据
                onSaved: (String value) {
                  _username = value;
                },
              ),
            ),
            new ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 260),
              child: _isLoginWay
                  ? new TextFormField(
                      controller: _passwordController,
                      focusNode: _focusNodePassWord,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "请输入密码",
                          // 是否显示密码
                          suffixIcon: IconButton(
                            icon: Icon((_isShowPwd)
                                ? Icons.visibility
                                : Icons.visibility_off),
                            // 点击改变显示或隐藏密码
                            onPressed: () {
                              setState(() {
                                _isShowPwd = !_isShowPwd;
                              });
                            },
                          )),
                      obscureText: !_isShowPwd,
                      //密码验证
                      validator: validatePassWord,
                      //保存数据
                      onSaved: (String value) {
                        _password = value;
                      },
                    )
                  : new TextFormField(
                      controller: _phoneCodeController,
                      focusNode: _focusNodeCode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "验证码",
                          hintText: "请输入验证码",
                          suffixIcon: RaisedButton(
                              color: Colors.white,
                              elevation: 0.0,
                              child: Text(
                                _isCode
                                    ? _codeText
                                    : "" + this._codeNumber.toString() + 's',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                              onPressed: () {
                                if (this._userNameController.text == null ||
                                    this._userNameController.text.length != 11) {
                                  ToastUtils.showToast_1("请先输入手机号码");
                                  return;
                                }
                                if(this._codeText=='重新发送验证码'){
                                  getCode();
                                }else{
                                  getImgCode();
                                }

                              })),
                      obscureText: false,
                      //保存数据
                      onSaved: (String value) {
                        _phoneCode = value;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
//
//    Widget dialogCode = new Container()
    /// 登录按钮区域
    Widget loginButtonArea = new Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        height: 100.0,
        child: Column(
          children: <Widget>[
            ButtonTheme(
                minWidth: 260.0, //设置最小宽度
                height: 44.0,
                child: new RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    _isLoginWay ? "密码登陆" : "验证码登陆",
//                    style: Theme.of(context).primaryTextTheme.headline,
                    style: TextStyle(fontSize: 18),
                  ),
                  // 设置按钮圆角
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    //点击登录按钮，解除焦点，回收键盘
                    _focusNodePassWord.unfocus();
                    _focusNodeUserName.unfocus();
                    _focusNodeCode.unfocus();

                    if (_formKey.currentState.validate()) {
                      //只有输入通过验证，才会执行这里
                      _formKey.currentState.save();
                      //todo 登录操作
                      print("$_username + $_password");
                      login();
                    }
                  },
                )),
            ButtonTheme(
              minWidth: 260.0, //设置最小宽度
              height: 44.0,
              child: new RaisedButton(
                color: Colors.white,
                elevation: 0.0,
                child: Text(
                  _isLoginWay ? "切换验证码登陆" : "切换密码登陆",
//                  style: Theme.of(context).primaryTextTheme.headline,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                // 设置按钮圆角
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  //点击登录按钮，解除焦点，回收键盘
                  _focusNodePassWord.unfocus();
                  _focusNodeUserName.unfocus();
                  _focusNodeCode.unfocus();

                  setState(() {
                    _isLoginWay = !_isLoginWay;
                  });
                },
              ),
            ),
          ],
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
          _focusNodeCode.unfocus();
        },
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_logo.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: new ListView(
            children: <Widget>[
              new SizedBox(
                height: 220,
              ),
//              logoImageArea,
//              logoName,

//            bottomArea,
              new SizedBox(
                height: 20,
              ),
              inputTextArea,
              new SizedBox(
                height: 30,
              ),
              loginButtonArea,
            ],
          ),
        )


      ),
    );
  }
}
