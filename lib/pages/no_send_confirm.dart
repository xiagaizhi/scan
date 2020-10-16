import 'package:flutter/material.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
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

class NoSendConfirmState extends State<NoSendConFirmPage> {
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
        setState(() {});
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
    });
  }

  initData() async {
    orderDataList = List();
    dataList = List();
    OrderTable orderTable = OrderTable();
    // SqlHelper.deleteAll(orderTable);
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    for (Map<String, dynamic> map in list) {
      OrderData data = new OrderData();
      orderDataList.add(data);
      data.fromJson(map);
      handleCompanyData(data);
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
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
                      _onReStartScanClick(context);
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
                      child: Text("${_totalBatch(companyData.batchList)}条"),
                    )
                  ],
                ),
              ),
              Offstage(
                offstage: _isHideBatch(companyData.batchList[index]),
                child: ExpansionTile(
                  title: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Text("批次号：${companyData.batchList[index].batchNumber}"),
                        Container(
                          padding: EdgeInsets.only(left: 18),
                          child: Text(
                              "${_totalGoods(companyData.batchList[index].goodsList)}条"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        child:
                                            Text("快递单号:${item.expressNumber}"),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7)),
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
                                          _onDeleteClick(companyData, item);
                                        },
                                      ))
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          );
        }, childCount: companyData.batchList.length),
      );
      slivers.add(sliverList);
    }
    return slivers;
  }

  _isHideBatch(BatchData batchData) {
    bool hide = true;
    for (GoodsData goodsData in batchData.goodsList) {
      if (goodsData.needDeliver == 1) {
        hide = false;
        break;
      }
    }
    return hide;
  }

  _totalBatch(List<BatchData> list) {
    int total = 0;
    for (BatchData batchData in list) {
      bool has = false;
      for (GoodsData goodsData in batchData.goodsList) {
        if (goodsData.needDeliver == 1) {
          has = true;
          break;
        }
      }
      if (has) {
        total++;
      }
    }
    return total;
  }

  _totalGoods(List<GoodsData> goodsList) {
    int total = 0;
    for (GoodsData goodsData in goodsList) {
      if (goodsData.needDeliver == 1) {
        total++;
      }
    }
    return total;
  }

  _onDeleteClick(CompanyData companyData, GoodsData goodsData) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            content: Container(
              height: 30,
              alignment: Alignment.center,
              child: Text('是否确认删除?'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  handleDelete(companyData, goodsData);
                  Navigator.pop(context);
                },
                textColor: Colors.red,
                child: Text('确认'),
              ),
            ],
          );
        });
  }

  handleDelete(CompanyData companyData, GoodsData item) async {
    setState(() {
      item.needDeliver = 0;
      for (BatchData batchData in companyData.batchList) {
        for (GoodsData goodsData in batchData.goodsList) {
          if (goodsData.taskItemId == item.taskItemId) {
            goodsData.needDeliver = item.needDeliver;
          }
        }
      }
    });
    OrderTable orderTable = OrderTable();
    await SqlHelper.update(orderTable,
        {"taskItemId": item.taskItemId, "needDeliver": item.needDeliver});
  }

  _onReStartScanClick(BuildContext context) async {
    print("继续扫码");
    await PageUtil.scanNoSend(context, false);
    setState(() {
      initData();
    });
  }

  _onConfirmClick() async {
    print("确认提交");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            content: Container(
              height: 30,
              alignment: Alignment.center,
              child: Text('确认提交不发货面单信息?'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  postSendGoods();
                },
                textColor: Colors.red,
                child: Text('确认'),
              ),
            ],
          );
        });
  }

  postSendGoods() async{
    OrderTable orderTable = OrderTable();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    ResultData resultData = await NetWorkUtil.updateNoSendOrder(list);
    if (resultData.isSuccess()) {
      SqlHelper.deleteAll(orderTable);
      setState(() {
        dataList = List();
      });
    }
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
