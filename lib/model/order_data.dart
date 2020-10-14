import 'dart:convert';

import 'package:scan/generated/json/base/json_convert_content.dart';

class OrderData with JsonConvert<OrderData> {
  String consignmentNumber;
  String createTime;
  String expressStatus;
  int id;
  String needDeliver;
  OrderOrderFlag orderFlag;
  int orderId;
  String orderNumber;
  String status;
  int supplierId;
  String supplierName;
  int taskId;
  int taskItemId;

  @override
  String toString() {
    return 'OrderData{consignmentNumber: $consignmentNumber, createTime: $createTime, expressStatus: $expressStatus, id: $id, needDeliver: $needDeliver, orderFlag: $orderFlag, orderId: $orderId, orderNumber: $orderNumber, status: $status, supplierId: $supplierId, supplierName: $supplierName, taskId: $taskId, taskItemId: $taskItemId}';
  }

  Map<String, dynamic> toStringMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consignmentNumber'] = this.consignmentNumber.toString();
    data['createTime'] = this.createTime.toString();
    data['expressStatus'] = this.expressStatus.toString();
    data['id'] = this.id;
    data['needDeliver'] = this.needDeliver.toString();
    if (this.orderFlag != null) {
      data['orderFlag'] = this.orderFlag.toJson();
    }
    data['orderId'] = this.orderId.toString();
    data['orderNumber'] = this.orderNumber.toString();
    data['status'] = this.status.toString();
    data['supplierId'] = this.supplierId.toString();
    data['supplierName'] = this.supplierName.toString();
    data['taskId'] = this.taskId.toString();
    data['taskItemId'] = this.taskItemId.toString();
    return data;
  }

  toOrderData( Map<String, dynamic> json) {
    if (json['consignmentNumber'] != null) {
      this.consignmentNumber = json['consignmentNumber']?.toString();
    }
    if (json['createTime'] != null) {
      this.createTime = json['createTime']?.toString();
    }
    if (json['expressStatus'] != null) {
      this.expressStatus = json['expressStatus']?.toString();
    }
    if (json['id'] != null) {
      this.id = json['id'] as int;
    }
    if (json['needDeliver'] != null) {
      this.needDeliver = json['needDeliver']?.toString();
    }
    if (json['orderFlag'] != null) {
      // data.orderFlag = new OrderOrderFlag().fromJson(new Map<String, dynamic>.from(json['orderFlag']));
      this.orderFlag = new OrderOrderFlag().fromJson(jsonDecode(json['orderFlag']));
    }
    if (json['orderId'] != null) {
      this.orderId = int.parse(json['orderId']);
    }
    if (json['orderNumber'] != null) {
      this.orderNumber = json['orderNumber']?.toString();
    }
    if (json['status'] != null) {
      this.status = json['status']?.toString();
    }
    if (json['supplierId'] != null) {
      this.supplierId =int.parse( json['supplierId']);
    }
    if (json['supplierName'] != null) {
      this.supplierName = json['supplierName']?.toString();
    }
    if (json['taskId'] != null) {
      this.taskId = int.parse(json['taskId']);
    }
    if (json['taskItemId'] != null) {
      this.taskItemId = int.parse(json['taskItemId']);
    }
    return this;
  }
}

class OrderOrderFlag with JsonConvert<OrderOrderFlag> {

}
