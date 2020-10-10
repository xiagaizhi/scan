import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  var title = "demo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('电子面单扫描'),
        leading: IconButton(
          icon: new Icon(Icons.aspect_ratio),
          onPressed: (){
            scan(type: ScanType.ALL);
          },
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.table_chart),
            tooltip: "Scan",
            onPressed: () {
              scan(type: ScanType.ALL);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
//              color: Colors.blue,
              elevation: 10,
              margin: EdgeInsets.all(6),
              child: Container(height: 100,child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      dense: true,
                      title: Text('不发货面单扫码'),
                      subtitle: Text("可用于标记各发货批次中现在“不发货”的订单"),
                      onTap: () {
                        scan(type: ScanType.QR);
                      }),
                ],
              ),)
            ),
            Card(
              elevation: 10,
              margin: EdgeInsets.all(6),
              child: Container(height: 100, child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      dense: true,
                      title: Text('单个面单发货扫码'),
                      subtitle: Text("可用于单个面单的订单信息查询及发货操作"),
                      onTap: () {
                        scan(type: ScanType.OTHER);
                      }),
                ],
              ),)
            ),
            Card(
              elevation: 10,
              margin: EdgeInsets.all(6),
              child: Container(height: 100, child: Column(
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
              ),)
            ),
            Text("提示：如需扫描商家端后台的各类信息修改二维码，请使用左上角的扫一扫即可。"),
            Text(title)
          ],
        ),
      ),
    );
  }

  Future scan({ScanType type = ScanType.QR}) async {
    ScanOptions options = ScanOptions(strings: {
      "cancel": "取消",
      "flash_on": "关灯",
      "flash_off": "开灯",
    }, restrictFormat: getQrFormat(type));
    try {
      var result = await BarcodeScanner.scan(options: options);
      print(result);
      title = "type:" + result.type.toString() + "\n";
      title += "format:" + result.format.toString() + "\n";
      title += "rawContent:" + result.rawContent.toString() + "\n";
      title += "formatNote:" + result.formatNote.toString() + "\n";
      setState(() {});
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
    }
  }

  List<BarcodeFormat> getQrFormat(ScanType type) {
    List<BarcodeFormat> list = new List();
    switch (type) {
      case ScanType.QR:
        list.add(BarcodeFormat.qr);
        break;
      case ScanType.OTHER:
        list.addAll(BarcodeFormat.values);
        list.remove(BarcodeFormat.qr);
        break;
      case ScanType.ALL:
        list.addAll(BarcodeFormat.values);
        break;
    }
    return list;
  }
}

enum ScanType { QR, OTHER, ALL }
