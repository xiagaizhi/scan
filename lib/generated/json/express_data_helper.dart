import 'package:scan/model/express_data.dart';

expressDataFromJson(ExpressData data, Map<String, dynamic> json) {
	if (json['consignmentNumber'] != null) {
		data.consignmentNumber = json['consignmentNumber'];
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'];
	}
	if (json['expressStatus'] != null) {
		data.expressStatus = json['expressStatus'];
	}
	if (json['id'] != null) {
		data.id = json['id'];
	}
	if (json['orderFlag'] != null) {
		data.orderFlag = json['orderFlag'];
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId'];
	}
	if (json['orderNumber'] != null) {
		data.orderNumber = json['orderNumber'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'];
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName'];
	}
	return data;
}

Map<String, dynamic> expressDataToJson(ExpressData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['consignmentNumber'] = entity.consignmentNumber;
	data['createTime'] = entity.createTime;
	data['expressStatus'] = entity.expressStatus;
	data['id'] = entity.id;
	data['orderFlag'] = entity.orderFlag;
	data['orderId'] = entity.orderId;
	data['orderNumber'] = entity.orderNumber;
	data['status'] = entity.status;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	return data;
}