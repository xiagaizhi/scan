import 'package:scan/generated/json/base/json_convert_content.dart';

class CodeBeanEntity with JsonConvert<CodeBeanEntity> {
	CodeBeanData data;
	String errorCode;
	String errorMsg;
	String status;
}

class CodeBeanData with JsonConvert<CodeBeanData> {
	String createTime;
	String expireTime;
	String key;
	String value;
}
