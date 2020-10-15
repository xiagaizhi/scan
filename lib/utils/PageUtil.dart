import 'package:scan/model/order_data.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/ienv.dart';
import 'package:scan/network/network_manager.dart';
import 'package:scan/sql/order_table.dart';
import 'package:scan/sql/sql_helper.dart';

class PageUtil {
  static handleScanEvent(String number) async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics).post(
            "/admin/print-task-item/get-base-order-by-express",
            {"expressNo": "111114540522"});
    OrderTable orderTable = OrderTable();
    if (resultData.data == null) {
      return;
    }
    for (Map<String, dynamic> map in resultData.data) {
      OrderData orderData = OrderData();
      orderData.fromJson(map);
      await SqlHelper.insert(orderTable, orderData.toJson());
    }
  }
}
