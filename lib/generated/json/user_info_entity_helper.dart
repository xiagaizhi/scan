import 'package:scan/model/user_info_entity.dart';

userInfoEntityFromJson(UserInfoEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['account'] != null) {
		data.account = json['account']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['loginTime'] != null) {
		data.loginTime = json['loginTime']?.toString();
	}
	if (json['regTime'] != null) {
		data.regTime = json['regTime']?.toString();
	}
	if (json['userRelations'] != null) {
		data.userRelations = new List<UserInfoUserRelation>();
		(json['userRelations'] as List).forEach((v) {
			data.userRelations.add(new UserInfoUserRelation().fromJson(v));
		});
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['sid'] != null) {
		data.sid = json['sid']?.toString();
	}
	if (json['signCode'] != null) {
		data.signCode = json['signCode']?.toString();
	}
	return data;
}

Map<String, dynamic> userInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['account'] = entity.account;
	data['name'] = entity.name;
	data['mobile'] = entity.mobile;
	data['email'] = entity.email;
	data['loginTime'] = entity.loginTime;
	data['regTime'] = entity.regTime;
	if (entity.userRelations != null) {
		data['userRelations'] =  entity.userRelations.map((v) => v.toJson()).toList();
	}
	data['token'] = entity.token;
	data['sid'] = entity.sid;
	data['signCode'] = entity.signCode;
	return data;
}

userInfoUserRelationFromJson(UserInfoUserRelation data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['extId'] != null) {
		data.extId = json['extId']?.toString();
	}
	if (json['enable'] != null) {
		data.enable = json['enable']?.toInt();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['updateTime'] != null) {
		data.updateTime = json['updateTime']?.toString();
	}
	return data;
}

Map<String, dynamic> userInfoUserRelationToJson(UserInfoUserRelation entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['extId'] = entity.extId;
	data['enable'] = entity.enable;
	data['createTime'] = entity.createTime;
	data['updateTime'] = entity.updateTime;
	return data;
}