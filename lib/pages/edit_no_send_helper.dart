import 'dart:async';

import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/sql/no_send_order_table.dart';
import 'package:scan/sql/sql_helper.dart';
import 'package:scan/utils/NetWorkUtil.dart';
import 'package:scan/utils/ToastUtils.dart';
import 'package:scan/utils/dialog_manager.dart';

class EditNoSendOrderData with _NoSendMoreBloc {
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
            onDataChanged(this);
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
        onDataChanged(this);
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
    onDataChanged(this);
  }

  initData() async {
    print("build init data---------------------");
    orderDataList = List();
    dataList = List();
    OrderTable orderTable = OrderTable();
    // SqlHelper.deleteAll(orderTable);
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    print(list.length);
    for (Map<String, dynamic> map in list) {
      OrderData data = new OrderData();
      orderDataList.add(data);
      data.fromJson(map);
      handleCompanyData(data);
    }
  }

  isHideBatch(BatchData batchData) {
    bool hide = true;
    for (GoodsData goodsData in batchData.goodsList) {
      if (goodsData.needDeliver == 0) {
        hide = false;
        break;
      }
    }
    return hide;
  }

  totalBatch(List<BatchData> list) {
    int total = 0;
    for (BatchData batchData in list) {
      bool has = false;
      for (GoodsData goodsData in batchData.goodsList) {
        if (goodsData.needDeliver == 0) {
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

  totalGoods(List<GoodsData> goodsList) {
    int total = 0;
    for (GoodsData goodsData in goodsList) {
      if (goodsData.needDeliver == 0) {
        total++;
      }
    }
    return total;
  }

  handleDelete(CompanyData companyData, GoodsData item) async {
    item.needDeliver = 1;
    for (BatchData batchData in companyData.batchList) {
      for (GoodsData goodsData in batchData.goodsList) {
        if (goodsData.taskItemId == item.taskItemId) {
          goodsData.needDeliver = item.needDeliver;
        }
      }
    }
    OrderTable orderTable = OrderTable();
    await SqlHelper.update(orderTable,
        {"taskItemId": item.taskItemId, "needDeliver": item.needDeliver});
    onDataChanged(this);
  }

  postSendGoods(context) async {
    OrderTable orderTable = OrderTable();
    List<Map<String, dynamic>> list = await SqlHelper.queryAll(orderTable);
    ResultData resultData = await NetWorkUtil.updateNoSendOrder(list);
    if (resultData.isSuccess()) {
      ToastUtils.showToast_1("操作成功");
      SqlHelper.deleteAll(orderTable);
      dataList = List();
    } else {
      DialogManger.getInstance().showNormalDialog(context, resultData.errorMsg);
    }
    onDataChanged(this);
  }

  deleteAllSendOrder() {
    OrderTable orderTable = OrderTable();
    SqlHelper.deleteByColumn(orderTable, "needDeliver", 1);
    onDataChanged(this);
  }
}

class _NoSendMoreBloc<T> {
  final _noSendController = new StreamController<EditNoSendOrderData>.broadcast();

  Stream<EditNoSendOrderData> get dataStream => _noSendController.stream;

  Sink<EditNoSendOrderData> get dataSink => _noSendController.sink;

  void onDataChanged(EditNoSendOrderData noSendOrderData) {
    if (!_noSendController.isClosed)
      _noSendController.sink.add(noSendOrderData);
  }

  void dispose() {
    _noSendController.close();
  }
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
