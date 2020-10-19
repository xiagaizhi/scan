import 'package:flutter/material.dart';
import 'package:scan/pages/failure_order_helper.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/utils/dialog_manager.dart';

import 'no_send_order_helper.dart';

class FailureOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FailureOrderState();
  }
}

class FailureOrderState extends State<FailureOrderPage> {
  FailureOrderHelper _helper = FailureOrderHelper();

  @override
  void initState() {
    super.initState();
    _helper.initData();
  }

  @override
  void dispose() {
    super.dispose();
    _helper.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("失效面单确认"),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                child: StreamBuilder(
                    stream: _helper.dataStream,
                    initialData: _helper,
                    builder: (data, stream) {
                      return CustomScrollView(
                        slivers: _buildListView(context, _helper),
                      );
                    })),
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
      )),
    );
  }

  List<Widget> _buildListView(context, data) {
    List<SliverList> slivers = List();
    for (int i = 0; i < data.dataList.length; i++) {
      FailureCompanyData companyData = data.dataList[i];
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
                      child: Text("${data.totalGoods(companyData.goodsList)}条"),
                    )
                  ],
                ),
              ),
              Offstage(
                offstage: item.needDeliver == 1,
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

  Future<bool> _onWillPop() async {
    _helper.deleteAllSendOrder();
    return true;
  }

  _onReStartScanClick(BuildContext context) async {
    print("继续扫码");
    PageUtil.scaFailureBarCode(context, true);
  }

  _onConfirmClick(parentContext) {
    print("确认提交");
    DialogManger.getInstance().show2ButtonDialog(context,
        content: "提交后在对应供应商后台失效面单管理列表中可正常查看数据，且原面单失效时间显示为确认提交的时间?",
        callBack: () async {
      _helper.postSendGoods(context);
    });
  }

  _onDeleteClick(FailureCompanyData companyData, GoodsData goodsData) async {
    DialogManger.getInstance().show2ButtonDialog(context,
        confirmText: "删除", content: "是否确认删除?", callBack: () {
      _helper.handleDelete(companyData, goodsData);
    });
  }
}
