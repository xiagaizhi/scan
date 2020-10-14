import 'package:scan/model/order_detail_data.dart';

orderDetailDataFromJson(OrderDetailData data, Map<String, dynamic> json) {
	if (json['bizSourceId'] != null) {
		data.bizSourceId = json['bizSourceId'];
	}
	if (json['cancelStatus'] != null) {
		data.cancelStatus = json['cancelStatus'];
	}
	if (json['consignee'] != null) {
		data.consignee = json['consignee'];
	}
	if (json['consigneeAddress'] != null) {
		data.consigneeAddress = json['consigneeAddress'];
	}
	if (json['consigneeAreaId'] != null) {
		data.consigneeAreaId = json['consigneeAreaId'];
	}
	if (json['consigneeAreaName'] != null) {
		data.consigneeAreaName = json['consigneeAreaName'];
	}
	if (json['consigneeCityName'] != null) {
		data.consigneeCityName = json['consigneeCityName'];
	}
	if (json['consigneeMobile'] != null) {
		data.consigneeMobile = json['consigneeMobile'];
	}
	if (json['consigneeProvinceName'] != null) {
		data.consigneeProvinceName = json['consigneeProvinceName'];
	}
	if (json['consigneeTime'] != null) {
		data.consigneeTime = json['consigneeTime'];
	}
	if (json['consignmentCompanyId'] != null) {
		data.consignmentCompanyId = json['consignmentCompanyId'];
	}
	if (json['consignmentCompanyName'] != null) {
		data.consignmentCompanyName = json['consignmentCompanyName'];
	}
	if (json['consignmentNumber'] != null) {
		data.consignmentNumber = json['consignmentNumber'];
	}
	if (json['consignmentRemark'] != null) {
		data.consignmentRemark = json['consignmentRemark'];
	}
	if (json['consignmentType'] != null) {
		data.consignmentType = json['consignmentType'];
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'];
	}
	if (json['creatorId'] != null) {
		data.creatorId = json['creatorId'];
	}
	if (json['creatorMobile'] != null) {
		data.creatorMobile = json['creatorMobile'];
	}
	if (json['creatorName'] != null) {
		data.creatorName = json['creatorName'];
	}
	if (json['creatorRemark'] != null) {
		data.creatorRemark = json['creatorRemark'];
	}
	if (json['deliverTime'] != null) {
		data.deliverTime = json['deliverTime'];
	}
	if (json['extId'] != null) {
		data.extId = json['extId'];
	}
	if (json['freight'] != null) {
		data.freight = json['freight'];
	}
	if (json['id'] != null) {
		data.id = json['id'];
	}
	if (json['items'] != null) {
		data.items = new List<OrderDetailItem>();
		(json['items'] as List).forEach((v) {
			data.items.add(new OrderDetailItem().fromJson(v));
		});
	}
	if (json['logisticsType'] != null) {
		data.logisticsType = json['logisticsType'];
	}
	if (json['logs'] != null) {
		data.logs = new List<OrderDetailLog>();
		(json['logs'] as List).forEach((v) {
			data.logs.add(new OrderDetailLog().fromJson(v));
		});
	}
	if (json['money'] != null) {
		data.money = json['money'];
	}
	if (json['number'] != null) {
		data.number = json['number'];
	}
	if (json['orderLogs'] != null) {
		data.orderLogs = new List<OrderDetailOrderLog>();
		(json['orderLogs'] as List).forEach((v) {
			data.orderLogs.add(new OrderDetailOrderLog().fromJson(v));
		});
	}
	if (json['orderSalesReturn'] != null) {
		data.orderSalesReturn = new OrderDetailOrderSalesReturn().fromJson(json['orderSalesReturn']);
	}
	if (json['paymentType'] != null) {
		data.paymentType = json['paymentType'];
	}
	if (json['selfPointId'] != null) {
		data.selfPointId = json['selfPointId'];
	}
	if (json['selfPointName'] != null) {
		data.selfPointName = json['selfPointName'];
	}
	if (json['sellerRemark'] != null) {
		data.sellerRemark = json['sellerRemark'];
	}
	if (json['sourceFreight'] != null) {
		data.sourceFreight = json['sourceFreight'];
	}
	if (json['sourceMoney'] != null) {
		data.sourceMoney = json['sourceMoney'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'];
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName'];
	}
	if (json['tradeId'] != null) {
		data.tradeId = json['tradeId'];
	}
	if (json['tradeNumber'] != null) {
		data.tradeNumber = json['tradeNumber'];
	}
	if (json['tradeTime'] != null) {
		data.tradeTime = json['tradeTime'];
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	return data;
}

Map<String, dynamic> orderDetailDataToJson(OrderDetailData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bizSourceId'] = entity.bizSourceId;
	data['cancelStatus'] = entity.cancelStatus;
	data['consignee'] = entity.consignee;
	data['consigneeAddress'] = entity.consigneeAddress;
	data['consigneeAreaId'] = entity.consigneeAreaId;
	data['consigneeAreaName'] = entity.consigneeAreaName;
	data['consigneeCityName'] = entity.consigneeCityName;
	data['consigneeMobile'] = entity.consigneeMobile;
	data['consigneeProvinceName'] = entity.consigneeProvinceName;
	data['consigneeTime'] = entity.consigneeTime;
	data['consignmentCompanyId'] = entity.consignmentCompanyId;
	data['consignmentCompanyName'] = entity.consignmentCompanyName;
	data['consignmentNumber'] = entity.consignmentNumber;
	data['consignmentRemark'] = entity.consignmentRemark;
	data['consignmentType'] = entity.consignmentType;
	data['createTime'] = entity.createTime;
	data['creatorId'] = entity.creatorId;
	data['creatorMobile'] = entity.creatorMobile;
	data['creatorName'] = entity.creatorName;
	data['creatorRemark'] = entity.creatorRemark;
	data['deliverTime'] = entity.deliverTime;
	data['extId'] = entity.extId;
	data['freight'] = entity.freight;
	data['id'] = entity.id;
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	data['logisticsType'] = entity.logisticsType;
	if (entity.logs != null) {
		data['logs'] =  entity.logs.map((v) => v.toJson()).toList();
	}
	data['money'] = entity.money;
	data['number'] = entity.number;
	if (entity.orderLogs != null) {
		data['orderLogs'] =  entity.orderLogs.map((v) => v.toJson()).toList();
	}
	if (entity.orderSalesReturn != null) {
		data['orderSalesReturn'] = entity.orderSalesReturn.toJson();
	}
	data['paymentType'] = entity.paymentType;
	data['selfPointId'] = entity.selfPointId;
	data['selfPointName'] = entity.selfPointName;
	data['sellerRemark'] = entity.sellerRemark;
	data['sourceFreight'] = entity.sourceFreight;
	data['sourceMoney'] = entity.sourceMoney;
	data['status'] = entity.status;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['tradeId'] = entity.tradeId;
	data['tradeNumber'] = entity.tradeNumber;
	data['tradeTime'] = entity.tradeTime;
	data['type'] = entity.type;
	return data;
}

orderDetailItemFromJson(OrderDetailItem data, Map<String, dynamic> json) {
	if (json['goodsCategoryId'] != null) {
		data.goodsCategoryId = json['goodsCategoryId'];
	}
	if (json['goodsCategoryName'] != null) {
		data.goodsCategoryName = json['goodsCategoryName'];
	}
	if (json['goodsCover'] != null) {
		data.goodsCover = json['goodsCover'];
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'];
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'];
	}
	if (json['goodsProperties'] != null) {
		data.goodsProperties = new List<OrderDetailItemsGoodsProperty>();
		(json['goodsProperties'] as List).forEach((v) {
			data.goodsProperties.add(new OrderDetailItemsGoodsProperty().fromJson(v));
		});
	}
	if (json['goodsSkuId'] != null) {
		data.goodsSkuId = json['goodsSkuId'];
	}
	if (json['goodsType'] != null) {
		data.goodsType = json['goodsType'];
	}
	if (json['lastPrice'] != null) {
		data.lastPrice = json['lastPrice'];
	}
	if (json['num'] != null) {
		data.num = json['num'];
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId'];
	}
	if (json['orderItemId'] != null) {
		data.orderItemId = json['orderItemId'];
	}
	if (json['orderSalesReturnId'] != null) {
		data.orderSalesReturnId = json['orderSalesReturnId'];
	}
	if (json['orderSalesReturnNumber'] != null) {
		data.orderSalesReturnNumber = json['orderSalesReturnNumber'];
	}
	if (json['orderSalesReturnStatus'] != null) {
		data.orderSalesReturnStatus = json['orderSalesReturnStatus'];
	}
	if (json['orderSalesReturnType'] != null) {
		data.orderSalesReturnType = json['orderSalesReturnType'];
	}
	if (json['price'] != null) {
		data.price = json['price'];
	}
	if (json['relationClassesId'] != null) {
		data.relationClassesId = json['relationClassesId'];
	}
	if (json['relationClassesNum'] != null) {
		data.relationClassesNum = json['relationClassesNum'];
	}
	if (json['relationGrade'] != null) {
		data.relationGrade = json['relationGrade'];
	}
	if (json['relationSchoolId'] != null) {
		data.relationSchoolId = json['relationSchoolId'];
	}
	if (json['relationSchoolName'] != null) {
		data.relationSchoolName = json['relationSchoolName'];
	}
	if (json['relationStudentId'] != null) {
		data.relationStudentId = json['relationStudentId'];
	}
	if (json['relationStudentName'] != null) {
		data.relationStudentName = json['relationStudentName'];
	}
	if (json['salesReturnType'] != null) {
		data.salesReturnType = json['salesReturnType'];
	}
	if (json['sourcePrice'] != null) {
		data.sourcePrice = json['sourcePrice'];
	}
	if (json['supportSalesReturn'] != null) {
		data.supportSalesReturn = json['supportSalesReturn'];
	}
	return data;
}

Map<String, dynamic> orderDetailItemToJson(OrderDetailItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsCategoryId'] = entity.goodsCategoryId;
	data['goodsCategoryName'] = entity.goodsCategoryName;
	data['goodsCover'] = entity.goodsCover;
	data['goodsId'] = entity.goodsId;
	data['goodsName'] = entity.goodsName;
	if (entity.goodsProperties != null) {
		data['goodsProperties'] =  entity.goodsProperties.map((v) => v.toJson()).toList();
	}
	data['goodsSkuId'] = entity.goodsSkuId;
	data['goodsType'] = entity.goodsType;
	data['lastPrice'] = entity.lastPrice;
	data['num'] = entity.num;
	data['orderId'] = entity.orderId;
	data['orderItemId'] = entity.orderItemId;
	data['orderSalesReturnId'] = entity.orderSalesReturnId;
	data['orderSalesReturnNumber'] = entity.orderSalesReturnNumber;
	data['orderSalesReturnStatus'] = entity.orderSalesReturnStatus;
	data['orderSalesReturnType'] = entity.orderSalesReturnType;
	data['price'] = entity.price;
	data['relationClassesId'] = entity.relationClassesId;
	data['relationClassesNum'] = entity.relationClassesNum;
	data['relationGrade'] = entity.relationGrade;
	data['relationSchoolId'] = entity.relationSchoolId;
	data['relationSchoolName'] = entity.relationSchoolName;
	data['relationStudentId'] = entity.relationStudentId;
	data['relationStudentName'] = entity.relationStudentName;
	data['salesReturnType'] = entity.salesReturnType;
	data['sourcePrice'] = entity.sourcePrice;
	data['supportSalesReturn'] = entity.supportSalesReturn;
	return data;
}

orderDetailItemsGoodsPropertyFromJson(OrderDetailItemsGoodsProperty data, Map<String, dynamic> json) {
	if (json['propertyId'] != null) {
		data.propertyId = json['propertyId'];
	}
	if (json['propertyName'] != null) {
		data.propertyName = json['propertyName'];
	}
	if (json['propertyValue'] != null) {
		data.propertyValue = json['propertyValue'];
	}
	if (json['propertyValueId'] != null) {
		data.propertyValueId = json['propertyValueId'];
	}
	return data;
}

Map<String, dynamic> orderDetailItemsGoodsPropertyToJson(OrderDetailItemsGoodsProperty entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['propertyId'] = entity.propertyId;
	data['propertyName'] = entity.propertyName;
	data['propertyValue'] = entity.propertyValue;
	data['propertyValueId'] = entity.propertyValueId;
	return data;
}

orderDetailLogFromJson(OrderDetailLog data, Map<String, dynamic> json) {
	if (json['createTime'] != null) {
		data.createTime = json['createTime'];
	}
	if (json['creatorId'] != null) {
		data.creatorId = json['creatorId'];
	}
	if (json['creatorName'] != null) {
		data.creatorName = json['creatorName'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['statusDesc'] != null) {
		data.statusDesc = json['statusDesc'];
	}
	return data;
}

Map<String, dynamic> orderDetailLogToJson(OrderDetailLog entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createTime'] = entity.createTime;
	data['creatorId'] = entity.creatorId;
	data['creatorName'] = entity.creatorName;
	data['status'] = entity.status;
	data['statusDesc'] = entity.statusDesc;
	return data;
}

orderDetailOrderLogFromJson(OrderDetailOrderLog data, Map<String, dynamic> json) {
	if (json['canalStatus'] != null) {
		data.canalStatus = json['canalStatus'];
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'];
	}
	if (json['creatorId'] != null) {
		data.creatorId = json['creatorId'];
	}
	if (json['creatorName'] != null) {
		data.creatorName = json['creatorName'];
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId'];
	}
	if (json['orderStatus'] != null) {
		data.orderStatus = json['orderStatus'];
	}
	return data;
}

Map<String, dynamic> orderDetailOrderLogToJson(OrderDetailOrderLog entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['canalStatus'] = entity.canalStatus;
	data['createTime'] = entity.createTime;
	data['creatorId'] = entity.creatorId;
	data['creatorName'] = entity.creatorName;
	data['orderId'] = entity.orderId;
	data['orderStatus'] = entity.orderStatus;
	return data;
}

orderDetailOrderSalesReturnFromJson(OrderDetailOrderSalesReturn data, Map<String, dynamic> json) {
	if (json['createTime'] != null) {
		data.createTime = json['createTime'];
	}
	if (json['id'] != null) {
		data.id = json['id'];
	}
	if (json['number'] != null) {
		data.number = json['number'];
	}
	if (json['sourceOrderId'] != null) {
		data.sourceOrderId = json['sourceOrderId'];
	}
	if (json['sourceOrderItemId'] != null) {
		data.sourceOrderItemId = json['sourceOrderItemId'];
	}
	if (json['sourceOrderNumber'] != null) {
		data.sourceOrderNumber = json['sourceOrderNumber'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	return data;
}

Map<String, dynamic> orderDetailOrderSalesReturnToJson(OrderDetailOrderSalesReturn entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createTime'] = entity.createTime;
	data['id'] = entity.id;
	data['number'] = entity.number;
	data['sourceOrderId'] = entity.sourceOrderId;
	data['sourceOrderItemId'] = entity.sourceOrderItemId;
	data['sourceOrderNumber'] = entity.sourceOrderNumber;
	data['status'] = entity.status;
	data['type'] = entity.type;
	return data;
}