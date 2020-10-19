import 'package:flutter/material.dart';

class DialogManger {
  DialogManger._();

  static final _instance = DialogManger._();

  factory DialogManger.getInstance() => _instance;

  showNormalDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            content: Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(msg),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('好的'),
              ),
            ],
          );
        });
  }

  show2ButtonDialog(BuildContext context,
      {String title = "提示",
      String content,
      String confirmText = "确认",
      Function callBack}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(content),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  callBack();
                },
                textColor: Colors.red,
                child: Text(confirmText),
              ),
            ],
          );
        });
  }
}
