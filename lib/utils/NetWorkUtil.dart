import 'package:scan/model/result_data.dart';
import 'package:scan/network/ienv.dart';
import 'package:scan/network/network_manager.dart';

class NetWorkUtil {
  /// 更新批量任务中订单的发货状态
  static updateOrderSendStatus(List<dynamic> list) async {
    ResultData resultData =
        await HttpManager.getInstance(type: UrlType.logistics)
            .post("/admin/print-task-item/update-order-deliver-status", list);
    return resultData;
  }
}
