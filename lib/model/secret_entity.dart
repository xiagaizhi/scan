import 'package:scan/generated/json/base/json_convert_content.dart';

class SecretEntity with JsonConvert<SecretEntity> {
	String createTime;
	String expireTime;
	String keyId;
	String publicKey;
}
