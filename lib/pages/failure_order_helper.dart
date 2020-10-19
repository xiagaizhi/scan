import 'dart:async';

import 'package:scan/model/express_data_entity.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/sql/failure_order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/NetWorkUtil.dart';
import 'package:scan/utils/dialog_manager.dart';

import 'no_send_order_helper.dart';

class FailureOrderHelper with _FailureOrderBloc {
  List<FailureCompanyData> dataList = List();
  List<ExpressData> expressList = List();

  initData() async {
    dataList = List();
    expressList = List();
    FailureOrderTable table = FailureOrderTable();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(table);
    for (Map<String, dynamic> map in list) {
      print(map);
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
        onDataChanged(this);
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
    onDataChanged(this);
  }

  postSendGoods(context) async {
    FailureOrderTable table = FailureOrderTable();
    List request = List();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(table);
    for (Map map in list) {
      print(map);
      ExpressData data = new ExpressData();
      data.fromJson(map);
      if (data.needDeliver == 0) {
        request.add(data.id);
      }
    }
    ResultData resultData = await NetWorkUtil.updateFailureOrder(request);
    if (resultData.isSuccess()) {
      SqlHelper.deleteAll(table);
      onDataChanged(this);
    } else {
      DialogManger.getInstance().showNormalDialog(context, resultData.errorMsg);
    }
  }

  handleDelete(FailureCompanyData companyData, GoodsData item) async {
    item.needDeliver = 1;
    FailureOrderTable table = FailureOrderTable();
    await SqlHelper.update(
        table, {"orderId": item.taskItemId, "needDeliver": item.needDeliver});
    onDataChanged(this);
  }

  totalGoods(List<GoodsData> list) {
    int total = 0;
    for (GoodsData goodsData in list) {
      if (goodsData.needDeliver == 0) {
        total++;
      }
    }
    return total;
  }

  deleteAllSendOrder() {
    FailureOrderTable table = FailureOrderTable();
    SqlHelper.deleteByColumn(table, "needDeliver", 1);
    onDataChanged(this);
  }
}

class _FailureOrderBloc<T> {
  final _noSendController =
      new StreamController<FailureOrderHelper>.broadcast();

  Stream<FailureOrderHelper> get dataStream => _noSendController.stream;

  Sink<FailureOrderHelper> get dataSink => _noSendController.sink;

  void onDataChanged(FailureOrderHelper noSendOrderData) {
    if (!_noSendController.isClosed)
      _noSendController.sink.add(noSendOrderData);
  }

  void dispose() {
    _noSendController.close();
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
