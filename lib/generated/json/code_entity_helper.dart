import 'package:scan/model/code_entity.dart';

codeBeanEntityFromJson(CodeBeanEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new CodeBeanData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toString();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	return data;
}

Map<String, dynamic> codeBeanEntityToJson(CodeBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	data['status'] = entity.status;
	return data;
}

codeBeanDataFromJson(CodeBeanData data, Map<String, dynamic> json) {
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['expireTime'] != null) {
		data.expireTime = json['expireTime']?.toString();
	}
	if (json['key'] != null) {
		data.key = json['key']?.toString();
	}
	if (json['value'] != null) {
		data.value = json['value']?.toString();
	}
	return data;
}

Map<String, dynamic> codeBeanDataToJson(CodeBeanData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createTime'] = entity.createTime;
	data['expireTime'] = entity.expireTime;
	data['key'] = entity.key;
	data['value'] = entity.value;
	return data;
}