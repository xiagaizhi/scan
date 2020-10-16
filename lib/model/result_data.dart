import 'package:scan/generated/json/base/json_convert_content.dart';
import 'package:scan/network/network_ststus.dart';

class ResultData with JsonConvert<ResultData> {
  dynamic errorCode;
  dynamic errorMsg;
  dynamic data;
  String status;

  @override
  String toString() {
    return 'ResultData{errorCode: $errorCode, errorMsg: $errorMsg, data: $data, status: $status}';
  }

  bool isSuccess() {
    return this.status == NetWorkStatus.OK;
  }

}
