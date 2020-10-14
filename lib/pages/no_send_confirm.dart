import 'package:flutter/material.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';

class NoSendConFirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoSendConfirmState();
  }
}

class NoSendConfirmState extends State<NoSendConFirmPage> {
  List<int> list;
  List<ExpandStateBean> expandStateList;
  List<CompanyData> dataList = List();

  void handleCompanyData(OrderData data) {
    for (CompanyData company in dataList) {
      if (company.id == data.supplierId) {
        BatchData batchData = BatchData();
        batchData.batchNumber = data.taskId;
        List<GoodsData> goodsList = List();
        GoodsData goodsData = GoodsData();
        goodsData.orderIdNumber = data.orderId;
        goodsData.expressNumber = data.orderId;
        goodsList.add(goodsData);
        batchData.goodsList = goodsList;
        company.batchList.add(batchData);
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
    GoodsData goodsData = GoodsData();
    goodsData.orderIdNumber = data.orderId;
    goodsData.expressNumber = data.orderId;
    goodsList.add(goodsData);
    batchData.goodsList = goodsList;
    batchList.add(batchData);
    companyData.batchList = batchList;
    dataList.add(companyData);
    setState(() {});
  }

  handleData() async {
    OrderTable orderTable = OrderTable();
    // SqlHelper.deleteAll(orderTable);
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    for (Map<String, dynamic> map in list) {
      OrderData data = new OrderData();
      data.toOrderData(map);
      handleCompanyData(data);
      print(data.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    handleData();
    list = new List();
    expandStateList = new List();
    for (int i = 0; i < 10; i++) {
      list.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }

  test() async {
    ResultData resultData = await HttpManager.getInstance().post(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: _buildListView(),
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
          return Column(
            children: <Widget>[
              Offstage(
                offstage: index != 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.card_giftcard),
                    Text(companyData.name),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Text("${companyData.batchList.length}条"),
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Container(
                  color: Colors.blue,
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
                    .map((item) => Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("快递单号:${item.expressNumber}"),
                                Text("订单号:${item.orderIdNumber}"),
                              ],
                            ),
                            Container(
                              child: Text("删除"),
                            )
                          ],
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

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpand;
        }
      });
    });
  }
}

class ExpandStateBean {
  var isOpen;
  var index;

  ExpandStateBean(this.index, this.isOpen);
}

class CompanyData {
  String name;
  int id;
  List<BatchData> batchList;

  CompanyData.name(this.name, this.id, this.batchList);

  CompanyData();
}

class BatchData {
  int batchNumber;
  List<GoodsData> goodsList;
}

class GoodsData {
  int expressNumber;
  int orderIdNumber;
}
