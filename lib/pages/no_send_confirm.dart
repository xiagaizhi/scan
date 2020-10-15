import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/ienv.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/NetWorkUtil.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan_plugin/call_back.dart';
import 'package:scan_plugin/data/scan_result_data.dart';
import 'package:scan_plugin/scan_plugin.dart';

class NoSendConFirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoSendConfirmState();
  }
}

class NoSendConfirmState extends State<NoSendConFirmPage> with ICallBack {
  List<CompanyData> dataList = List();
  List<OrderData> orderDataList = List();

  void handleCompanyData(OrderData data) {
    for (CompanyData company in dataList) {
      if (company.id == data.supplierId) {
        for (BatchData batchData in company.batchList) {
          if (batchData.batchNumber == data.taskId) {
            GoodsData goodsData =
                GoodsData(data.taskItemId, data.taskItemId, data.needDeliver);
            batchData.goodsList.add(goodsData);
            setState(() {});
            return;
          }
        }
        BatchData batchData = BatchData();
        batchData.batchNumber = data.taskId;
        List<GoodsData> goodsList = List();
        GoodsData goodsData =
            GoodsData(data.taskItemId, data.taskItemId, data.needDeliver);
        goodsList.add(goodsData);
        batchData.goodsList = goodsList;
        company.batchList.add(batchData);
        setState(() {
          print("setState----------------------------");
          print(data);
          print(goodsData);
          print(dataList[0]);
        });
        return;
      }
    }
    CompanyData companyData = CompanyData();
    companyData.name = data.supplierName;
    companyData.id = data.supplierId;
    List<BatchData> batchList = List();
    BatchData batchData = BatchData();
    batchData.batchNumber = data.taskId;
    List<GoodsData> goodsList = List();
    GoodsData goodsData =
        GoodsData(data.taskItemId, data.taskItemId, data.needDeliver);
    goodsList.add(goodsData);
    batchData.goodsList = goodsList;
    batchList.add(batchData);
    companyData.batchList = batchList;
    dataList.add(companyData);
    setState(() {
      print("first  setState----------------------------");
      print(dataList[0]);
    });
  }

  handleData() async {
    OrderTable orderTable = OrderTable();
    // SqlHelper.deleteAll(orderTable);
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    for (Map<String, dynamic> map in list) {
      print(map);
      OrderData data = new OrderData();
      orderDataList.add(data);
      data.fromJson(map);
      print(data);
      handleCompanyData(data);
    }
  }

  @override
  void initState() {
    super.initState();
    handleData();
    ScanPlugin.register(this);
  }

  @override
  void dispose() {
    super.dispose();
    ScanPlugin.remove(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
              fit: FlexFit.tight,
              child: CustomScrollView(
                slivers: _buildListView(),
              )),
          Container(
            height: 64,
            width: double.infinity,
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("继续扫码"),
                    ),
                    onTap: () {
                      _onReStartScanClick();
                    },
                  ),
                ),
                Flexible(
                  child: SizedBox(),
                  fit: FlexFit.tight,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text("确认提交"),
                    ),
                    onTap: () {
                      _onConfirmClick();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  List<Widget> _buildListView() {
    List<SliverList> slivers = List();
    for (int i = 0; i < dataList.length; i++) {
      CompanyData companyData = dataList[i];
      SliverList sliverList = SliverList(
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          //创建列表项
          print(companyData.batchList[index].goodsList[0].needDeliver);
          return Column(
            children: <Widget>[
              Offstage(
                offstage: index != 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.card_giftcard),
                    Text("${companyData.name}"),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Text("${companyData.batchList.length}条"),
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      Text("批次号：${companyData.batchList[index].batchNumber}"),
                      Container(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                            "${companyData.batchList[index].goodsList.length}条"),
                      )
                    ],
                  ),
                ),
                children: companyData.batchList[index].goodsList
                    .map((item) => Offstage(
                          offstage: item.needDeliver == 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 15, right: 5),
                            height: 70,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("快递单号:${item.expressNumber}"),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 7, bottom: 7)),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("订单号:${item.taskItemId}"),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: SizedBox(),
                                  fit: FlexFit.tight,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      child: Text("删除"),
                                      onTap: () {
                                        _onDeleteClick(item);
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              )
            ],
          );
        }, childCount: companyData.batchList.length),
      );
      slivers.add(sliverList);
    }
    print(slivers.length);
    return slivers;
  }

  _onDeleteClick(GoodsData goodsData) async {
    print(goodsData);
    setState(() {
      goodsData.needDeliver = 0;
    });
    OrderTable orderTable = OrderTable();
    var lisy = await SqlHelper.query(orderTable, goodsData.taskItemId);
    print(lisy);
    await SqlHelper.update(orderTable, {
      "taskItemId": goodsData.taskItemId,
      "needDeliver": goodsData.needDeliver
    });
    print(goodsData.needDeliver == 0);
    print(await SqlHelper.query(orderTable, goodsData.taskItemId));
  }

  _onReStartScanClick() {
    print("继续扫码");
  }

  _onConfirmClick() async {
    print("确认提交");
    OrderTable orderTable = OrderTable();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    ResultData resultData = await NetWorkUtil.updateOrderSendStatus(list);
    if (resultData.isSuccess()) {
      SqlHelper.deleteAll(orderTable);
      setState(() {
        dataList = List();
      });
    }
  }

  @override
  void callBack(ScanResultData data) {
    PageUtil.handleScanEvent(data.data);
  }
}

class ExpandStateBean {
  var isOpen;
  var index;

  ExpandStateBean(this.index, this.isOpen);
}

class CompanyData {
  dynamic name;
  dynamic id;
  List<BatchData> batchList;

  @override
  String toString() {
    return 'CompanyData{name: $name, id: $id, batchList: $batchList}';
  }

  CompanyData.name(this.name, this.id, this.batchList);

  CompanyData();
}

class BatchData {
  dynamic batchNumber;
  List<GoodsData> goodsList;

  @override
  String toString() {
    return 'BatchData{batchNumber: $batchNumber, goodsList: $goodsList}';
  }
}

class GoodsData {
  dynamic expressNumber;
  dynamic taskItemId;
  dynamic needDeliver;

  GoodsData(this.expressNumber, this.taskItemId, this.needDeliver);

  @override
  String toString() {
    return 'GoodsData{expressNumber: $expressNumber, taskItemId: $taskItemId, needDeliver: $needDeliver}';
  }
}
