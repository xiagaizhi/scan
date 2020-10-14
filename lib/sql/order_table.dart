import 'package:scan/model/order_data.dart';
import 'package:scan/sql/base_table.dart';

class OrderTable extends BaseTable {
  ///表名
  final String name = 'OrderTable';

  final String consignmentNumber = "consignmentNumber";
  final String createTime = "createTime";
  final String expressStatus = "expressStatus";
  final String id = "id";
  final String needDeliver = "needDeliver";
  final String orderFlag = "orderFlag";
  final String orderId = "orderId";
  final String orderNumber = "orderNumber";
  final String status = "status";
  final String supplierId = "supplierId";
  final String supplierName = "supplierName";
  final String taskId = "taskId";
  final String taskItemId = "taskItemId";

  @override
  createTableString() {
    return '''
        create table $name (
        $id integer primary key,
        $consignmentNumber text ,
        $createTime text ,
        $expressStatus text ,
        $needDeliver text,
        $orderFlag text ,
        $orderId text ,
        $orderNumber text ,
        $status text ,
        $supplierId text ,
        $supplierName text ,
        $taskId text ,
        $taskItemId text
        )
      ''';
  }

  @override
  tableName() {
    return name;
  }
}
