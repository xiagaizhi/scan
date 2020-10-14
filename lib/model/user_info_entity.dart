import 'package:scan/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	String uid;
	String account;
	String name;
	String mobile;
	String email;
	String loginTime;
	String regTime;
	List<UserInfoUserRelation> userRelations;
	String token;
	String sid;
	String signCode;
}

class UserInfoUserRelation with JsonConvert<UserInfoUserRelation> {
	String id;
	int type;
	String userId;
	String extId;
	int enable;
	String createTime;
	String updateTime;
}
