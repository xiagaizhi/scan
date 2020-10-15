import 'package:scan/model/order_data.dart';
import 'dart:convert';

orderDataFromJson(OrderData data, Map<String, dynamic> json) {
	if (json['consignmentNumber'] != null) {
		data.consignmentNumber = json['consignmentNumber']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['expressStatus'] != null) {
		data.expressStatus = json['expressStatus']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['needDeliver'] != null) {
		data.needDeliver = json['needDeliver']?.toString();
	}
	if (json['orderFlag'] != null) {
		data.orderFlag = new OrderOrderFlag().fromJson(json['orderFlag']);
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId']?.toInt();
	}
	if (json['orderNumber'] != null) {
		data.orderNumber = json['orderNumber']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId']?.toInt();
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName']?.toString();
	}
	if (json['taskId'] != null) {
		data.taskId = json['taskId']?.toInt();
	}
	if (json['taskItemId'] != null) {
		data.taskItemId = json['taskItemId']?.toInt();
	}
	return data;
}

Map<String, dynamic> orderDataToJson(OrderData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['consignmentNumber'] = entity.consignmentNumber;
	data['createTime'] = entity.createTime;
	data['expressStatus'] = entity.expressStatus;
	data['id'] = entity.id;
	data['needDeliver'] = entity.needDeliver;
	if (entity.orderFlag != null) {
		data['orderFlag'] = entity.orderFlag.toJson();
	}
	data['orderId'] = entity.orderId;
	data['orderNumber'] = entity.orderNumber;
	data['status'] = entity.status;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['taskId'] = entity.taskId;
	data['taskItemId'] = entity.taskItemId;
	return data;
}

orderOrderFlagFromJson(OrderOrderFlag data, Map<String, dynamic> json) {
	return data;
}

Map<String, dynamic> orderOrderFlagToJson(OrderOrderFlag entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	return data;
}