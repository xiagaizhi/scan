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
        title: Text('扫描'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            tooltip: "Scan",
            onPressed: () {
              scan(type: ScanType.ALL);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("二维码扫描"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                scan(type: ScanType.QR);
              },
            ),
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("条形码扫描"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                scan(type: ScanType.OTHER);
              },
            ),
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("所有码扫描"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                scan(type: ScanType.ALL);
              },
            ),
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
