import 'package:scan/generated/json/base/json_convert_content.dart';

class ExpressData with JsonConvert<ExpressData> {
	String id;
	String supplierId;
	String supplierName;
	int consignmentCompanyId;
	String consignmentCompanyName;
	String orderId;
	String orderNumber;
	String orderFlag;
	String expressNo;
	String status;
	String expressStatus;
	String createTime;
}
