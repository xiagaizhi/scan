
import 'package:flutter/cupertino.dart';

class EmptyView{

  //空页面展示
  static Widget emptyView = new Container(

    alignment: Alignment.topCenter,
    child: Container(
      margin: EdgeInsets.only(top: 100),
      child: Image(width:200,height:200,image: AssetImage("assets/images/kongshuju.png"),),
    )
  );


}