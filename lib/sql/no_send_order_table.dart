import 'package:scan/model/order_data.dart';
import 'package:scan/sql/base_table.dart';

class OrderTable extends BaseTable {
  ///表名
  final String name = 'OrderTable';

  final String expressNo = "expressNo";
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
  final String columnId = "columnId";
  final String orderStatus = "orderStatus";

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key AUTOINCREMENT,
        $id integer,
        $expressNo text ,
        $createTime text ,
        $expressStatus text ,
        $needDeliver integer,
        $orderFlag text ,
        $orderId text ,
        $orderNumber text ,
        $status text ,
        $supplierId text ,
        $supplierName text ,
        $taskId text ,
        $taskItemId text ,
        $orderStatus text
        )
      ''';
  }

  @override
  tableName() {
    return name;
  }

  @override
  String getPrimaryString() {
    return taskItemId;
  }
}
