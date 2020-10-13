import 'package:flutter/material.dart'
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {


  static Future showToast_1(val){
    Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,  // 消息框弹出的位置
        timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
        backgroundColor: Colors.grey[400],
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

}
