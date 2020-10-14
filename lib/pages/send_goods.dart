import 'package:flutter/material.dart';
import 'package:scan/model/express_data.dart';
import 'package:scan/model/order_detail_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/ienv.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/utils/ConvertUtil.dart';
import 'package:scan_plugin/data/scan_result_data.dart';

class SendGoodsPage extends StatefulWidget {
  final String data;

  const SendGoodsPage({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SendGoodsState();
  }
}

class SendGoodsState extends State<SendGoodsPage> {
  ScanResultData data = ScanResultData();

  @override
  void initState() {
    super.initState();
    data.fromJson(ConvertUtil.decode(widget.data));
    getExpressInfo(data.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("ssss"),
    );
  }

  getExpressInfo(String number) async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics)
            .post("/admin/eorder-using/get-eorder-base-info", {
      "expressNo": number,
      "expressStatus": ['0'],
      "status": ['1', '3']
    });
    List<ExpressData> list = List();
    for (Map<String, dynamic> map in resultData.data) {
      ExpressData expressDataData = ExpressData();
      expressDataData.fromJson(map);
      list.add(expressDataData);
    }
    if (list.length > 0) {
      getOrderDetail(list[0].orderId);
    }
  }

  getOrderDetail(String orderId) async {
    ResultData resultData = await HttpManager.getInstance(type: UrlType.order)
        .post("/admin/order/detail", {"orderId": orderId});
    OrderDetailData data = OrderDetailData();
    data.fromJson(resultData.data);
    print(data);
  }
}
