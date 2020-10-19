import 'package:flutter/material.dart';
import 'package:scan/utils/PageUtil.dart';
import 'package:scan/pages/no_send_order_helper.dart';
import 'package:scan/utils/dialog_manager.dart';

class NoSendOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoSendOrderState();
  }
}

class NoSendOrderState extends State<NoSendOrderPage> {
  NoSendOrderData _helper = NoSendOrderData();

  @override
  void initState() {
    super.initState();
    _helper.initData();
    print("initState(");
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
          title: Text("不发货面单确认"),
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
    List<Widget> slivers = List();
    Widget tip = SliverToBoxAdapter(
      child: Container(
        color: Colors.blueAccent,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 40,
        child: Text("以下面单是您标记为“不发货”的面单，请仔细核对！"),
      ),
    );
    slivers.add(tip);
    print("--------------------------------------");
    print(data);
    for (int i = 0; i < data.dataList.length; i++) {
      CompanyData companyData = data.dataList[i];
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
                    Text("${companyData.name}"),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Text("${data.totalBatch(companyData.batchList)}条"),
                    )
                  ],
                ),
              ),
              Offstage(
                offstage: data.isHideBatch(companyData.batchList[index]),
                child: ExpansionTile(
                  title: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Text("批次号：${companyData.batchList[index].batchNumber}"),
                        Container(
                          padding: EdgeInsets.only(left: 18),
                          child: Text(
                              "${data.totalGoods(companyData.batchList[index].goodsList)}条"),
                        )
                      ],
                    ),
                  ),
                  children: companyData.batchList[index].goodsList
                      .map((item) => Offstage(
                            offstage: item.needDeliver == 1,
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

  Future<bool> _onWillPop() async {
    _helper.deleteAllSendOrder();
    return true;
  }

  _onDeleteClick(CompanyData companyData, GoodsData goodsData) {
    DialogManger.getInstance().show2ButtonDialog(context,
        confirmText: "删除", content: "是否确认删除?", callBack: () {
      _helper.handleDelete(companyData, goodsData);
    });
  }

  _onReStartScanClick(BuildContext context) {
    print("继续扫码");
    PageUtil.scanNoSend(context, true);
  }

  _onConfirmClick(parentContext) {
    print("确认提交");
    DialogManger.getInstance()
        .show2ButtonDialog(context, content: "确认提交不发货面单信息", callBack: () async {
      _helper.postSendGoods(context);
    });
  }
}
