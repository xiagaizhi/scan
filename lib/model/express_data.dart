import 'package:scan/generated/json/base/json_convert_content.dart';

class ExpressData with JsonConvert<ExpressData> {
	dynamic consignmentNumber;
	dynamic createTime;
	dynamic expressStatus;
	dynamic id;
	dynamic orderFlag;
	dynamic orderId;
	dynamic orderNumber;
	dynamic status;
	dynamic supplierId;
	dynamic supplierName;

	@override
  String toString() {
    return 'ExpressData{consignmentNumber: $consignmentNumber, createTime: $createTime, expressStatus: $expressStatus, id: $id, orderFlag: $orderFlag, orderId: $orderId, orderNumber: $orderNumber, status: $status, supplierId: $supplierId, supplierName: $supplierName}';
  }
}
