import 'package:flutter/material.dart';
import 'package:scan/model/express_data_entity.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/pages/no_send_order_page.dart';
import 'package:scan/sql/failure_order_table.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/NetWorkUtil.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/utils/dialog_manager.dart';

class FailureOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FailureOrderState();
  }
}

class FailureOrderState extends State<FailureOrderPage> {
  List<FailureCompanyData> dataList;
  List<ExpressData> expressList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    dataList = List();
    expressList = List();
    FailureOrderTable table = FailureOrderTable();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(table);
    for (Map<String, dynamic> map in list) {
      ExpressData data = new ExpressData();
      expressList.add(data);
      data.fromJson(map);
      handleCompanyData(data);
    }
  }

  handleCompanyData(ExpressData expressData) {
    for (FailureCompanyData companyData in dataList) {
      if (companyData.id == expressData.supplierId) {
        GoodsData goodsData = GoodsData(
            expressData.orderId, expressData.orderId, expressData.needDeliver);
        companyData.goodsList.add(goodsData);
        setState(() {});
        return;
      }
    }
    FailureCompanyData data = FailureCompanyData();
    data.name = expressData.supplierName;
    data.id = expressData.supplierId;
    data.goodsList = List();
    GoodsData goodsData = GoodsData(
        expressData.orderId, expressData.orderId, expressData.needDeliver);
    data.goodsList.add(goodsData);
    dataList.add(data);
    setState(() {});
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
                      _onConfirmClick(context);
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
      FailureCompanyData companyData = dataList[i];
      SliverList sliverList = SliverList(
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          //创建列表项
          GoodsData item = companyData.goodsList[index];
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
                      child: Text("${_totalGoods(companyData.goodsList)}条"),
                    )
                  ],
                ),
              ),
              Offstage(
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
                            child: Text(
                                "快递单号:${companyData.goodsList[index].expressNumber}"),
                          ),
                          Padding(padding: EdgeInsets.only(top: 7, bottom: 7)),
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
              )
            ],
          );
        }, childCount: companyData.goodsList.length),
      );
      slivers.add(sliverList);
    }
    return slivers;
  }

  _totalGoods(List<GoodsData> list) {
    int total = 0;
    for (GoodsData goodsData in list) {
      if (goodsData.needDeliver == 1) {
        total++;
      }
    }
    return total;
  }

  _onReStartScanClick(BuildContext context) async {
    print("继续扫码");
    await PageUtil.scanNoSend(context, false);
    setState(() {
      initData();
    });
  }

  _onConfirmClick(parentContext) {
    print("确认提交");
    showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            content: Container(
              height: 70,
              alignment: Alignment.center,
              child: Text('提交后在对应供应商后台失效面单管理列表中可正常查看数据，且原面单失效时间显示为确认提交的时间?'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  postSendGoods(parentContext);
                },
                textColor: Colors.red,
                child: Text('确认'),
              ),
            ],
          );
        });
  }

  postSendGoods(context) async {
    List<dynamic> list = List();
    for (ExpressData expressData in expressList) {
      if (expressData.needDeliver == 1) {
        list.add(expressData.id);
      }
    }
    ResultData resultData = await NetWorkUtil.updateFailureOrder(list);
    FailureOrderTable table = FailureOrderTable();
    if (resultData.isSuccess()) {
      SqlHelper.deleteAll(table);
      setState(() {
        dataList = List();
      });
    } else {
      DialogManger.getInstance().showNormalDialog(context, resultData.errorMsg);
    }
  }

  _onDeleteClick(FailureCompanyData companyData, GoodsData goodsData) async {
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

  handleDelete(FailureCompanyData companyData, GoodsData item) async {
    setState(() {
      item.needDeliver = 0;
    });
    FailureOrderTable table = FailureOrderTable();
    await SqlHelper.update(
        table, {"orderId": item.taskItemId, "needDeliver": item.needDeliver});
  }
}

class FailureCompanyData {
  dynamic name;
  dynamic id;
  List<GoodsData> goodsList;

  @override
  String toString() {
    return 'CompanyData{name: $name, id: $id, goodsData: $goodsList}';
  }

  FailureCompanyData.name(this.name, this.id, this.goodsList);

  FailureCompanyData();
}
