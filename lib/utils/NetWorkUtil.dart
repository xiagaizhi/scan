import 'package:scan/constants/ienv.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_manager.dart';

class NetWorkUtil {
  /// 更新批量任务中订单的发货状态
  static Future<ResultData> updateNoSendOrder(List<dynamic> list) async {
    return await HttpManager.getInstance(type: UrlType.logistics)
        .post("/admin/print-task-item/update-order-deliver-status", list);
  }

  /// 更新失效面单
  static Future<ResultData> updateFailureOrder(List<dynamic> list) async {
    return await HttpManager.getInstance(type: UrlType.logistics)
        .post("/admin/eorder-expired-record/add", list);
  }

  ///获取物流单基本信息
  static Future<ResultData> getLogisticsOrderInfo(expressNo) async {
    return await HttpManager.getInstance(type: UrlType.logistics)
        .post("/admin/eorder-using/get-eorder-base-info", {
      "expressNo": expressNo,
      "expressStatus": ['0'],
      "status": ['1', '3']
    });
  }

  /// 通过物流单获取订单信息
  static Future<ResultData> getOrderByExpress(expressId) async {
    return await HttpManager.getInstance(type: UrlType.logistics).post(
        "/admin/print-task-item/get-base-order-by-express",
        {"expressNo": expressId});
  }

  ///不需要发货列表
  static Future<ResultData> getNoSendOrderList(id, supplierId) async {
    return await HttpManager.getInstance(type: UrlType.logistics).post(
        "/admin/print-task/not-need-deliver",
        {"id": id, "supplierId": supplierId});
  }
}
