import 'dart:convert';

import 'package:scan/generated/json/base/json_convert_content.dart';

class OrderData with JsonConvert<OrderData> {
  dynamic expressNo;
  dynamic createTime;
  dynamic expressStatus;
  dynamic id;
  dynamic needDeliver;
  dynamic orderFlag;
  dynamic orderId;
  dynamic orderNumber;
  dynamic status;
  dynamic supplierId;
  dynamic supplierName;
  dynamic taskId;
  dynamic taskItemId;

  @override
  String toString() {
    return 'OrderData{expressNo: $expressNo, createTime: $createTime, expressStatus: $expressStatus, id: $id, needDeliver: $needDeliver, orderFlag: $orderFlag, orderId: $orderId, orderNumber: $orderNumber, status: $status, supplierId: $supplierId, supplierName: $supplierName, taskId: $taskId, taskItemId: $taskItemId}';
  }

  Map<String, dynamic> toStringMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expressNo'] = this.expressNo.toString();
    data['createTime'] = this.createTime.toString();
    data['expressStatus'] = this.expressStatus.toString();
    data['id'] = int.parse(this.id);
    data['needDeliver'] = this.needDeliver;
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

  toOrderData(Map<String, dynamic> json) {
    if (json['expressNo'] != null) {
      this.expressNo = json['expressNo'];
    }
    if (json['createTime'] != null) {
      this.createTime = json['createTime'];
    }
    if (json['expressStatus'] != null) {
      this.expressStatus = json['expressStatus'];
    }
    if (json['id'] != null) {
      this.id = json['id'];
    }
    if (json['needDeliver'] != null) {
      this.needDeliver = json['needDeliver'];
    }
    if (json['orderFlag'] != null) {
      this.orderFlag = json['orderFlag'];
    }
    if (json['orderId'] != null) {
      this.orderId = json['orderId'];
    }
    if (json['orderNumber'] != null) {
      this.orderNumber = json['orderNumber'];
    }
    if (json['status'] != null) {
      this.status = json['status'];
    }
    if (json['supplierId'] != null) {
      this.supplierId = json['supplierId'];
    }
    if (json['supplierName'] != null) {
      this.supplierName = json['supplierName'];
    }
    if (json['taskId'] != null) {
      this.taskId = json['taskId'];
    }
    if (json['taskItemId'] != null) {
      this.taskItemId = json['taskItemId'];
    }
    return this;
  }
}
