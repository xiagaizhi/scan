import 'package:scan/model/web_qr_code_data.dart';

webQrCodeDataFromJson(WebQrCodeData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['printTaskId'] != null) {
		data.printTaskId = json['printTaskId']?.toString();
	}
	return data;
}

Map<String, dynamic> webQrCodeDataToJson(WebQrCodeData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['printTaskId'] = entity.printTaskId;
	return data;
}