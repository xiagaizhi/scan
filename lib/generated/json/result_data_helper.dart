import 'package:scan/model/result_data.dart';
import 'package:scan/network/network_ststus.dart';

resultDataFromJson(ResultData data, Map<String, dynamic> json) {
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode'];
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg'];
	}
	if (json['data'] != null) {
		data.data = json['data'];
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	return data;
}

Map<String, dynamic> resultDataToJson(ResultData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	data['data'] = entity.data;
	data['status'] = entity.status;
	return data;
}