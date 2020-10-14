import 'package:scan/model/secret_entity.dart';

secretEntityFromJson(SecretEntity data, Map<String, dynamic> json) {
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['expireTime'] != null) {
		data.expireTime = json['expireTime']?.toString();
	}
	if (json['keyId'] != null) {
		data.keyId = json['keyId']?.toString();
	}
	if (json['publicKey'] != null) {
		data.publicKey = json['publicKey']?.toString();
	}
	return data;
}

Map<String, dynamic> secretEntityToJson(SecretEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createTime'] = entity.createTime;
	data['expireTime'] = entity.expireTime;
	data['keyId'] = entity.keyId;
	data['publicKey'] = entity.publicKey;
	return data;
}