import 'package:scan/sql/base_table.dart';

class FailureOrderTable extends BaseTable {
  ///表名
  final String name = 'FailureOrderTable';

  final String consignmentCompanyId = "consignmentCompanyId";
  final String consignmentCompanyName = "consignmentCompanyName";
  final String createTime = "createTime";
  final String expressNo = "expressNo";
  final String expressStatus = "expressStatus";
  final String id = "id";
  final String orderFlag = "orderFlag";
  final String orderId = "orderId";
  final String orderNumber = "orderNumber";
  final String status = "status";
  final String supplierId = "supplierId";
  final String supplierName = "supplierName";
  final String rowId = "rowId";
  final String needDeliver = "needDeliver";

  @override
  createTableString() {
    return '''
        create table $name (
        $rowId integer primary key AUTOINCREMENT,
        $consignmentCompanyId text,
        $consignmentCompanyName text ,
        $createTime text ,
        $expressNo text ,
        $expressStatus text,
        $id text ,
        $orderFlag text ,
        $orderId text ,
        $orderNumber text ,
        $status text ,
        $supplierId text ,
        $supplierName text ,
        $needDeliver integer 
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
