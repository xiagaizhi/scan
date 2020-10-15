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
  OrderDetailData mOrderDetailData = OrderDetailData();

  @override
  void initState() {
    super.initState();
    mOrderDetailData.fromJson({
      "id": "1315551182285971458",
      "extId": "",
      "number": "2010121513330015140001",
      "type": "NORMAL",
      "paymentType": "NOT_NEED_PAY",
      "bizSourceId": 1,
      "createTime": "2020-10-12 15:13:33",
      "creatorId": "58123",
      "creatorName": "张w",
      "creatorMobile": "17685284881",
      "status": "CONFIRM",
      "cancelStatus": "NONE",
      "tradeId": "0",
      "tradeNumber": "",
      "tradeTime": "2020-10-12 15:13:33",
      "deliverTime": "2020-10-13 16:49:37",
      "consigneeTime": "2020-10-13 17:49:37",
      "supplierId": "1314381716223168514",
      "supplierName": "1009线下供应商",
      "sourceMoney": "8800",
      "money": "0",
      "sourceFreight": "0",
      "freight": "0",
      "logisticsType": "SELF_PICK",
      "selfPointId": "1314386786977366017",
      "selfPointName": "大坡路",
      "consignee": "zzz",
      "consigneeMobile": "17688888888",
      "consigneeAreaId": 520112,
      "consigneeProvinceName": "贵州省",
      "consigneeCityName": "贵阳市",
      "consigneeAreaName": "乌当区",
      "consigneeAddress": "新天社区服务中心新添大道北段32号",
      "consignmentType": "NONE",
      "consignmentCompanyId": 0,
      "consignmentCompanyName": null,
      "consignmentNumber": "",
      "consignmentRemark": "",
      "creatorRemark": null,
      "sellerRemark": null,
      "items": [
        {
          "orderItemId": "1315551182294360066",
          "orderId": "1315551182285971458",
          "goodsId": "1314410256452866049",
          "goodsName": "吃吃喝喝",
          "goodsCover": "1314409138775777282",
          "goodsType": "REALLY",
          "goodsSkuId": "1314410256624832526",
          "goodsProperties": [
            {
              "propertyId": "1314410256620638210",
              "propertyValueId": "1314410256620638222",
              "propertyValue": "155",
              "propertyName": "身高(CM)"
            },
            {
              "propertyId": "1314410256620638230",
              "propertyValueId": "1314410256620638231",
              "propertyValue": "男款",
              "propertyName": "款式"
            }
          ],
          "sourcePrice": "8800",
          "price": "0",
          "lastPrice": "0",
          "num": 1,
          "salesReturnType": "NOT_SUPPORT",
          "goodsCategoryId": "2",
          "goodsCategoryName": "其他",
          "relationSchoolId": "1314382013452521473",
          "relationSchoolName": "1009线下学校",
          "relationClassesId": "1314384590424510466",
          "relationClassesNum": 1,
          "relationGrade": "ONE",
          "relationStudentId": "1314388325724852225",
          "relationStudentName": "MM",
          "orderSalesReturnId": null,
          "orderSalesReturnNumber": null,
          "orderSalesReturnType": null,
          "orderSalesReturnStatus": null,
          "supportSalesReturn": false
        }
      ],
      "orderLogs": [
        {
          "orderId": "1315551182285971458",
          "orderStatus": "WAIT_PAY",
          "canalStatus": "NONE",
          "createTime": "2020-10-12 15:13:33",
          "creatorId": "58123",
          "creatorName": "张w"
        },
        {
          "orderId": "1315551182285971458",
          "orderStatus": "WAIT_EXPRESS",
          "canalStatus": "NONE",
          "createTime": "2020-10-12 15:13:33",
          "creatorId": "58123",
          "creatorName": "张w"
        },
        {
          "orderId": "1315551182285971458",
          "orderStatus": "WAIT_CONFIRM",
          "canalStatus": "NONE",
          "createTime": "2020-10-13 16:49:37",
          "creatorId": "332015",
          "creatorName": "-"
        },
        {
          "orderId": "1315551182285971458",
          "orderStatus": "CONFIRM",
          "canalStatus": "NONE",
          "createTime": "2020-10-13 17:49:37",
          "creatorId": "0",
          "creatorName": "系统"
        }
      ],
      "logs": [
        {
          "status": "PLACE_ORDER",
          "statusDesc": "已下单",
          "createTime": "2020-10-12 15:13:33",
          "creatorId": "58123",
          "creatorName": "张w"
        },
        {
          "status": "WAIT_EXPRESS",
          "statusDesc": "待发货",
          "createTime": "2020-10-12 15:13:33",
          "creatorId": "58123",
          "creatorName": "张w"
        },
        {
          "status": "DELIVER_GOODS",
          "statusDesc": "已发货",
          "createTime": "2020-10-13 16:49:37",
          "creatorId": "332015",
          "creatorName": "-"
        },
        {
          "status": "CONFIRM",
          "statusDesc": "已收货",
          "createTime": "2020-10-13 17:49:37",
          "creatorId": "0",
          "creatorName": "系统"
        }
      ],
      "orderSalesReturn": null
    });
    print(mOrderDetailData.toString());
    print(mOrderDetailData.consigneeAddress);
    data.fromJson(ConvertUtil.decode(widget.data));
//     getExpressInfo(data.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('订单详情信息'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left:16.0,top: 8.0,right: 16.0,bottom: 8.0),
          child: Column(
            children: [_buildCompany(), _buildAddress(), _buildList()],
          ),
        ));
  }

  Widget _buildCompany() {
    Widget widget = Row(
      children: [
        Icon(Icons.local_gas_station),
        Column(
          children: [
            Row(
              children: [Text("快递公司："), Text("某某公司")],
            ),
            Row(
              children: [Text("快递单号"), Text("快递单号")],
            )
          ],
        )
      ],
    );
    return widget;
  }

  Widget _buildAddress() {
    Widget widget = Row(
      children: [
        Icon(Icons.local_gas_station),
        Column(
          children: [
            Row(
              children: [
                Text("${mOrderDetailData.creatorName}"),
                Text("${mOrderDetailData.creatorMobile}")
              ],
            ),
            Row(
              children: [
                Text("${mOrderDetailData.consigneeProvinceName}" +
                    "${mOrderDetailData.consigneeCityName}" +
                    "${mOrderDetailData.consigneeAreaName}" +
                    "${mOrderDetailData.consigneeAddress}")
              ],
            ),
          ],
        )
      ],
    );
    return widget;
  }

  Widget _buildList() {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("订单号:${mOrderDetailData.items[0].orderId}"),
          ),
          Container(
              child: ListView.builder(
//                  itemCount: mOrderDetailData.items.length,
                  itemCount: 100,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        new SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'klsakjjshjfahfakhfakhfhkfskhahfjhfjhfjhfsjhfsjhfjhfjhfsjfajhfjafjfjjhfjhfjhfjhfjhfjhfjhfjhfsasjk',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16
                                ),

                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 20,
                              alignment: Alignment.centerRight,
                              child:Text(mOrderDetailData.items[0].sourcePrice),
                            ),
                          ],
                        ),
                        new SizedBox(height: 2, ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  mOrderDetailData.items[0].goodsName,
                                  maxLines:2),
                            ),
                            Container(
                              width: 50.0,
                              height: 20,
                              alignment: Alignment.centerRight,
                              child:
                              Text(4.toString()),
                            ),
                          ],
                        ),
                        new SizedBox(height: 2,),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              child: Text('学生：'+mOrderDetailData.items[0].relationStudentName),
                            ),
                            Container(
                              width: 50.0,
                                height: 20,
                              alignment: Alignment.centerRight,
                              child:null
                            ),
                          ],
                        ),
                        new SizedBox(height: 8,),
                        Divider(height: 1),
                      ],
                    );
                  })),
        ],
      ),
    );

//    Column(children: <Widget>[
//      ListTile(title: Text("订单号:${mOrderDetailData.items[0].orderId}")),
//      Container(
//        child: ListView.builder(
//            itemCount: mOrderDetailData.items.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Column(
//                children: [
//                  Stack(
//                    alignment: Alignment.center,
//                    children: [
//                      Container(
//                        child: Text("Hello world",
//                            style: TextStyle(color: Colors.white)),
//                        color: Colors.red,
//                      ),
//                      Positioned(
//                        left: 18.0,
//                        child: Text("I am Jack"),
//                      ),
//                      Positioned(
//                        right: 18.0,
//                        child: Text("Your friend"),
//                      )
//                    ],
//                  )
//                ],
//              );
//            }),
//      ),
//
//    ]);
    return widget;
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
