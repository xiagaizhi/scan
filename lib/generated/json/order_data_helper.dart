import 'package:scan/model/order_data.dart';
import 'dart:convert';

orderDataFromJson(OrderData data, Map<String, dynamic> json) {
	if (json['expressNo'] != null) {
		data.expressNo = json['expressNo'];
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
	if (json['needDeliver'] != null) {
		data.needDeliver = json['needDeliver'];
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
	if (json['taskId'] != null) {
		data.taskId = json['taskId'];
	}
	if (json['taskItemId'] != null) {
		data.taskItemId = json['taskItemId'];
	}
	return data;
}

Map<String, dynamic> orderDataToJson(OrderData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['expressNo'] = entity.expressNo;
	data['createTime'] = entity.createTime;
	data['expressStatus'] = entity.expressStatus;
	data['id'] = entity.id;
	data['needDeliver'] = entity.needDeliver;
	data['orderFlag'] = entity.orderFlag;
	data['orderId'] = entity.orderId;
	data['orderNumber'] = entity.orderNumber;
	data['status'] = entity.status;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['taskId'] = entity.taskId;
	data['taskItemId'] = entity.taskItemId;
	return data;
}