import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan/constants/ienv.dart';
import 'package:scan/model/express_data_entity.dart';
import 'package:scan/model/order_detail_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/utils/ConvertUtil.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan/view/empty-view.dart';
import 'package:scan_plugin/data/scan_result_data.dart';
import 'package:scan/pages/qr_scan_code.dart';

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
  OrderDetailData mOrderDetailData = OrderDetailData();

  @override
  void initState() {
    super.initState();
    data.fromJson(ConvertUtil.decode(widget.data));
    getExpressInfo(data.data);
  }

  Widget empty = EmptyView.emptyView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('订单详情信息'),
        centerTitle: true,
      ),
      body: mOrderDetailData == null || mOrderDetailData.id == null
          ? empty
          : Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 16.0, bottom: 6.0),
                      child: Column(
                        children: <Widget>[
                          new SizedBox(
                            height: 10,
                          ),
                          _buildCompany(),
                          new SizedBox(
                            height: 10,
                          ),
                          Divider(height: 1),
                          new SizedBox(
                            height: 10,
                          ),
                          _buildAddress(),
                          _buildList(),
                        ],
                      )),
                ),
                Container(
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
                              child: Text("重新扫码",style: TextStyle(color: Colors.white,fontSize: 14),),
                            ),
                            onTap: () {
                              PageUtil.scanSingleSend(context);
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
                                "确认发货",
                                style: TextStyle(color: Colors.white,fontSize: 14),
                              ),
                            ),
                            onTap: () {
                              sendDevices();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildCompany() {
    Widget widget = Row(
      children: [
        Image(
            width: 30,
            height: 30,
            image: AssetImage("assets/images/kuaidi.png")),
        Column(
          children: [
            Container(
              width: 280,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                  "快递公司：${mExpressData == null ? '-' : mExpressData.consignmentCompanyName}"),
            ),
            Container(
              width: 280,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                  "快递号：${mExpressData == null ? '-' : mExpressData.expressNo}"),
            ),
          ],
        )
      ],
    );
    return widget;
  }

  Widget _buildAddress() {
    Widget widget = Row(
      children: [
        Image(
            width: 26,
            height: 26,
            image: AssetImage("assets/images/dizhi.png")),
        Column(
          children: [
            Container(
              width: 280,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text("${_isStr(mOrderDetailData.creatorName)}" +
                  ':' +
                  "${_isStr(mOrderDetailData.creatorMobile)}"),
            ),
            Container(
              width: 280,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "${_isStr(mOrderDetailData.consigneeProvinceName)}" +
                    "${_isStr(mOrderDetailData.consigneeCityName)}" +
                    "${_isStr(mOrderDetailData.consigneeAreaName)}" +
                    "${_isStr(mOrderDetailData.consigneeAddress)}",
                maxLines: 2,
              ),
            ),
          ],
        )
      ],
    );
    return widget;
  }

  //规格字符串 合并
  String _getProper(int index) {
    var proStr = '';
    if (mOrderDetailData == null || mOrderDetailData.items == null) {
      return '';
    }
    mOrderDetailData.items[index].goodsProperties.forEach((v) {
      if (mOrderDetailData.items[index].goodsProperties.length == 1) {
        proStr = proStr + v.propertyName + ':' + v.propertyValue;
      } else {
        proStr = proStr + v.propertyName + ':' + v.propertyValue + '; ';
      }
    });
    return proStr;
  }

  String _isStr(String str) {
    if (str == null) {
      return '';
    } else {
      return str;
    }
  }

  //处理单价
  String _getPrice(String money) {
    String price = '';
    if (money == null) {
      price = '';
    } else {
      price = '￥' + (int.parse(money) / 100).toString();
    }
    return price;
  }

  // 获取总价
  String _getTotalMoney(String money, String freight) {
    String totalMoney = '';
    if (money == null || freight == null) {
      totalMoney = '';
    } else {
      totalMoney =
          '￥' + ((int.parse(money) * int.parse(freight)) / 100).toString();
    }

    return totalMoney;
  }

  Widget _buildList() {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          new SizedBox(
            height: 30,
          ),
          Container(
              width: 360,
              alignment: Alignment.centerLeft,
              child: Text("订单号:${_isStr(mOrderDetailData.number)}")),
          Container(
              child: ListView.builder(
                  itemCount: mOrderDetailData.items == null
                      ? 0
                      : mOrderDetailData.items.length,
//                  itemCount: 20,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        new SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${mOrderDetailData.items == null ? '-' : _isStr(mOrderDetailData.items[index].goodsName)}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 20,
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "${mOrderDetailData.items == null ? '-' : _getPrice(mOrderDetailData.items[index].sourcePrice)}"),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${_getProper(0)}",
                                maxLines: 2,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 20,
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "x${mOrderDetailData.items == null ? '-' : _isStr(mOrderDetailData.items[index].num.toString())}"),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "学生:${mOrderDetailData.items == null ? '-' : _isStr(mOrderDetailData.items[index].relationStudentName)}",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Container(
                                width: 50.0,
                                height: 20,
                                alignment: Alignment.centerRight,
                                child: null),
                          ],
                        ),
                        new SizedBox(
                          height: 8,
                        ),
                        Divider(height: 1),
                      ],
                    );
                  })),

          new SizedBox(
            height: 10,
          ),
          //商品总计
          Container(
              width: 360,
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 260.0,
                        height: 20,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '商品总价',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 20,
                        alignment: Alignment.centerRight,
                        child: Text(
                            "${_getTotalMoney(mOrderDetailData.sourceMoney, mOrderDetailData.freight)}"),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 260.0,
                        height: 20,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '运费',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 20,
                        alignment: Alignment.centerRight,
                        child: Text("${_getPrice(mOrderDetailData.freight)}"),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 260.0,
                        height: 20,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '订单总价',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 20,
                        alignment: Alignment.centerRight,
                        child:
                            Text("${_getPrice(mOrderDetailData.sourceMoney)}"),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 2,
                  ),
                ],
              )),
        ],
      ),
    );
    return widget;
  }

  //快递公司信息
  ExpressData mExpressData;

  getExpressInfo(String number) async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics)
            .post("/admin/eorder-using/get-eorder-base-info", {
      "expressNo": number,
      "expressStatus": ['0'],
      "status": ['1', '3']
    });
    if(resultData.status != 'OK'){
      ToastUtils.showToast_1(resultData.errorMsg.toString());
      return;
    }
    List<ExpressData> list = List();
    for (Map<String, dynamic> map in resultData.data) {
      ExpressData expressDataData = ExpressData();
      expressDataData.fromJson(map);
      list.add(expressDataData);
    }
    if (list.length > 0) {
      getOrderDetail(list[0].orderId);
      mExpressData = list[0];
    }
  }

  getOrderDetail(String orderId) async {
    ResultData resultData = await HttpManager.getInstance(type: UrlType.order)
        .post("/admin/order/detail", {"orderId": orderId});

    if(resultData.status != 'OK'){
      ToastUtils.showToast_1(resultData.errorMsg.toString());
      return;
    }

    setState(() {
      mOrderDetailData = OrderDetailData();
      mOrderDetailData.fromJson(resultData.data);
      print(mOrderDetailData);
    });
  }

  showErrorDialog(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Container(
              height: 46.0,
              padding: EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0, bottom: 2.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                msg,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(131, 131, 131, 1),
                  fontSize: 14,
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('好的'),
                onPressed: () {
                  Navigator.of(context).pop('ok');
                },
              ),
            ],
          );
        });
  }

  showMsgDialog(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Container(
              height: 46.0,
              padding: EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0, bottom: 2.0),
              alignment: Alignment.center,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(131, 131, 131, 1),
                  fontSize: 14,
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('继续发货'),
                onPressed: () {
                  PageUtil.scanSingleSend(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('发货完毕'),
                onPressed: () {
                  Navigator.of(context).pop('ok');
                  Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new QRCodePage()),
                    (route) => route == null,
                  );
                },
              ),
            ],
          );
        });
  }

  //确认发货
  sendDevices() async {
    var extData = {
      'consignmentCompanyId': mExpressData.consignmentCompanyId,
      'consignmentNumber': mExpressData.expressNo,
      'consignmentRemark': mOrderDetailData.consignmentRemark,
      'consignmentType': 'EXPRESS',
      'logisticsType': mOrderDetailData.logisticsType,
      'supplierId': mOrderDetailData.supplierId
    };
    var data = {
      'orderId': mOrderDetailData.id,
      'status': 'WAIT_CONFIRM',
      'extData': extData
    };
    ResultData resultData = await HttpManager.getInstance(type: UrlType.order)
        .post("/admin/order/deliver-goods", data);


    if (resultData.status != 'OK') {
      showErrorDialog(resultData.errorMsg.toString());
      return;
    }
    showMsgDialog("发货成功");
  }
}
