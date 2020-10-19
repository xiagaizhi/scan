import 'package:scan/model/order_data.dart';
import 'package:scan/sql/base_table.dart';

class EditNoSendTable extends BaseTable {
  ///表名
  final String name = 'EditNoSendTable';

  final String consignmentNumber = "consignmentNumber";
  final String id = "id";
  final String orderId = "orderId";
  final String orderNumber = "orderNumber";
  final String sequenceNumber = "sequenceNumber";
  final String columnId = "columnId";

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key AUTOINCREMENT,
        $consignmentNumber text,
        $id text,
        $orderId text ,
        $orderNumber text ,
        $sequenceNumber text 
        )
      ''';
  }

  @override
  tableName() {
    return name;
  }

  @override
  String getPrimaryString() {
    return orderId;
  }
}
