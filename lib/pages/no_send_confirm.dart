import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/utils/ConvertUtil.dart';
import 'package:scan_plugin/data/scan_result_data.dart';

class NoSendConFirmPage extends StatefulWidget {
  final String data;

  const NoSendConFirmPage({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NoSendConfirmState();
  }
}

class NoSendConfirmState extends State<NoSendConFirmPage> {
  List<int> list;
  List<ExpandStateBean> expandStateList;
  List<CompanyData> dataList = List();

  void initCompanyData() {
    for (int k = 0; k < 10; k++) {
      CompanyData companyData = CompanyData();
      companyData.name = "鸿星尔克";
      List<BatchData> batchList = List();
      for (int i = 0; i < 10; i++) {
        BatchData batchData = BatchData();
        batchData.batchNumber = "10086";
        List<GoodsData> goodsList = List();
        for (int j = 0; j < 10; j++) {
          GoodsData goodsData = GoodsData();
          goodsData.expressNumber = "10085";
          goodsData.orderIdNumber = "10084";
          goodsList.add(goodsData);
        }
        batchData.goodsList = goodsList;
        batchList.add(batchData);
        companyData.batchList = batchList;
      }
      dataList.add(companyData);
    }
  }

  @override
  void initState() {
    super.initState();
    ScanResultData data=ScanResultData();
    print("-----------------");
    print(ConvertUtil.decode(widget.data));
    print(data.fromJson(ConvertUtil.decode(widget.data)));
    list = new List();
    expandStateList = new List();
    for (int i = 0; i < 10; i++) {
      list.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
    initCompanyData();
  }

  test() async {
    ResultData resultData = await HttpManager.getInstance().post(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _buildListView(),
      ),
    );
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
  String batchNumber;
  List<GoodsData> goodsList;
}

class GoodsData {
  String expressNumber;
  String orderIdNumber;
}
