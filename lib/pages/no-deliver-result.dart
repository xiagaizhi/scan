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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('不发货面单确认'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            _ListItem(title: '1',),
            _ListItem(title: '2',),
            _ListItem(title: '3',),
            _ListItem(title: '4',),
            _ListItem(title: '5',),
            _ListItem(title: '6',),
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
    return Card(
      child: Container(
        height: 90,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            _ListItem2(title: '1111',),
            _ListItem2(title: '21111',)
          ],
        ),
      ),
    );
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
        alignment: Alignment.center,
        child: Text('$title'),
      ),
    );
  }
}
enum ScanType { QR, OTHER, ALL }
