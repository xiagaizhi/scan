import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 不发货面单结果

class NoDeliverResult extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<NoDeliverResult> {
  var title = "demo";
  var number = '3';
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('不发货面单确认'),
        centerTitle: true,
      ),
      bottomNavigationBar:BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.aspect_ratio,
              ),
              title: new Text(
                '继续扫码',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_upward,
              ),
              title: new Text(
                '确认提交',
              )),

        ],
        //这是底部导航栏自带的位标属性，表示底部导航栏当前处于哪个导航标签。给他一个初始值0，也就是默认第一个标签页面。
        currentIndex: _currentIndex,
        //这是点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
        onTap: (int i) {
          //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
          setState(() {
            _currentIndex = i;
          });
        },
      ),
      body: Center(

        child: ListView(
          children: <Widget>[
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text("以下面单是您标记为 “不发货” 的面单，请仔细核对"),
            ),
            Card(
//              color: Colors.blue,
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45,
                      color: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Text("商家名称： 贵州惠佳花职服务有限公司"),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.red),
                            child: Text(
                              '$number',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    Container(
                      height: 45,
                      color: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Container(width: 240, child: Text("批次号：20124525512")),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.red),
                            child: Text(
                              '$number',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.expand_more),
                          )
                        ],
                      ),
                    ),
                    _ListItem(title: '1'),
                  ],
                )),
            Card(
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    _ListItem(title: '2'),
                  ],
                )),
            Card(
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    _ListItem(title: '3'),
                  ],
                )),
            Card(
                elevation: 10,
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    _ListItem(title: '4'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;

  const _ListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _ListItem2(title: '1111-----');
        });
  }
}

class _ListItem2 extends StatelessWidget {
  final String title;

  const _ListItem2({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 45,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Container(
              width: 200,
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Text("快递单号："),
                  Text("订单号："),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              child: Text('删除'),
              color: Colors.blue,
              onPressed: () {},
              elevation: 10.0,
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}












class _Suffix extends StatelessWidget {
  final String text;

  const _Suffix({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(color: Colors.grey.withOpacity(.5)),
    );
  }
}

class _NotificationsText extends StatelessWidget {
  final String text;

  const _NotificationsText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.red),
      child: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
//class SettingDemo extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        _SettingItem(
//          iconData: Icons.notifications,
//          iconColor: Colors.blue,
//          title: '消息中心',
//          suffix: _NotificationsText(
//            text: '2',
//          ),
//        ),
//        Divider(),
//      ],
//    );
//  }
//}

enum ScanType { QR, OTHER, ALL }
