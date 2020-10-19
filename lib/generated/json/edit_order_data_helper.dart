import 'package:scan/model/edit_order_data.dart';
import 'package:scan/model/order_data.dart';

editOrderDataFromJson(EditOrderData data, Map<String, dynamic> json) {
	if (json['consignmentNumber'] != null) {
		data.consignmentNumber = json['consignmentNumber'];
	}
	if (json['id'] != null) {
		data.id = json['id'];
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId'];
	}
	if (json['orderNumber'] != null) {
		data.orderNumber = json['orderNumber'];
	}
	if (json['sequenceNumber'] != null) {
		data.sequenceNumber = json['sequenceNumber'];
	}
	return data;
}

Map<String, dynamic> editOrderDataToJson(EditOrderData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['consignmentNumber'] = entity.consignmentNumber;
	data['id'] = entity.id;
	data['orderId'] = entity.orderId;
	data['orderNumber'] = entity.orderNumber;
	data['sequenceNumber'] = entity.sequenceNumber;
	return data;
}