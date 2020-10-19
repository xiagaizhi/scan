import 'package:scan/model/express_data_entity.dart';

expressDataFromJson(ExpressData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId']?.toString();
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName']?.toString();
	}
	if (json['consignmentCompanyId'] != null) {
		data.consignmentCompanyId = json['consignmentCompanyId']?.toString();
	}
	if (json['consignmentCompanyName'] != null) {
		data.consignmentCompanyName = json['consignmentCompanyName']?.toString();
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId']?.toString();
	}
	if (json['orderNumber'] != null) {
		data.orderNumber = json['orderNumber']?.toString();
	}
	if (json['orderFlag'] != null) {
		data.orderFlag = json['orderFlag']?.toString();
	}
	if (json['expressNo'] != null) {
		data.expressNo = json['expressNo']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['expressStatus'] != null) {
		data.expressStatus = json['expressStatus']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['needDeliver'] != null) {
		data.needDeliver = json['needDeliver'];
	}
	return data;
}

Map<String, dynamic> expressDataToJson(ExpressData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['consignmentCompanyId'] = entity.consignmentCompanyId;
	data['consignmentCompanyName'] = entity.consignmentCompanyName;
	data['orderId'] = entity.orderId;
	data['orderNumber'] = entity.orderNumber;
	data['orderFlag'] = entity.orderFlag;
	data['expressNo'] = entity.expressNo;
	data['status'] = entity.status;
	data['expressStatus'] = entity.expressStatus;
	data['createTime'] = entity.createTime;
	data['needDeliver'] = entity.needDeliver;
	return data;
}