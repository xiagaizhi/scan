

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomView {


  static Widget getBottomVieww(String str,String str2){
    return  new Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 165,
            height: 44,
            color: Color.fromRGBO(151, 197, 245, 1),
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(str,style: TextStyle(color: Colors.white,fontSize: 14),),
                ),
                onTap: () {
//                PageUtil.scanSingleSend(context);
                },
              ),
            ),
          ),
          Flexible(
            child: SizedBox(),
            fit: FlexFit.tight,
          ),
          Container(
            width: 165,
            height: 44,
            color: Color.fromRGBO(37, 135, 235, 1),
            margin: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    str2,
                    style: TextStyle(color: Colors.white,fontSize: 14),
                  ),
                ),
                onTap: () {
//                sendDevices();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}