
import 'package:scan/generated/json/base/json_convert_content.dart';

class ResultData with JsonConvert<ResultData> {
	dynamic errorCode;
	dynamic errorMsg;
	dynamic data;
	String status;

	@override
  String toString() {
    return 'ResultData{errorCode: $errorCode, errorMsg: $errorMsg, data: $data, status: $status}';
  }
}
