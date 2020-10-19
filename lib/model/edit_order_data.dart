import 'package:scan/generated/json/base/json_convert_content.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/model/web_qr_code_data.dart';

class EditOrderData with JsonConvert<EditOrderData> {
  dynamic consignmentNumber;
  dynamic id;
  dynamic orderId;
  dynamic orderNumber;
  dynamic sequenceNumber;

  @override
  String toString() {
    return 'EditOrderData{consignmentNumber: $consignmentNumber, id: $id, orderId: $orderId, orderNumber: $orderNumber, sequenceNumber: $sequenceNumber}';
  }

  OrderData cast2OrderData(WebQrCodeData webQrCodeData) {
    OrderData orderData = OrderData();
    orderData.supplierId = webQrCodeData.id;
    orderData.taskId = webQrCodeData.printTaskId;
    orderData.taskItemId = this.id;
    orderData.expressNo = this.consignmentNumber;
    orderData.orderId = orderId;
    orderData.needDeliver = 0;
    orderData.supplierName = webQrCodeData.name;
    return orderData;
  }
}
