import 'package:scan/generated/json/base/json_convert_content.dart';

class OrderDetailData with JsonConvert<OrderDetailData> {
	dynamic bizSourceId;
	dynamic cancelStatus;
	dynamic consignee;
	dynamic consigneeAddress;
	dynamic consigneeAreaId;
	dynamic consigneeAreaName;
	dynamic consigneeCityName;
	dynamic consigneeMobile;
	dynamic consigneeProvinceName;
	dynamic consigneeTime;
	dynamic consignmentCompanyId;
	dynamic consignmentCompanyName;
	dynamic consignmentNumber;
	dynamic consignmentRemark;
	dynamic consignmentType;
	dynamic createTime;
	dynamic creatorId;
	dynamic creatorMobile;
	dynamic creatorName;
	dynamic creatorRemark;
	dynamic deliverTime;
	dynamic extId;
	dynamic freight;
	dynamic id;
	List<OrderDetailItem> items;
	dynamic logisticsType;
	List<OrderDetailLog> logs;
	dynamic money;
	dynamic number;
	List<OrderDetailOrderLog> orderLogs;
	OrderDetailOrderSalesReturn orderSalesReturn;
	dynamic paymentType;
	dynamic selfPointId;
	dynamic selfPointName;
	dynamic sellerRemark;
	dynamic sourceFreight;
	dynamic sourceMoney;
	dynamic status;
	dynamic supplierId;
	dynamic supplierName;
	dynamic tradeId;
	dynamic tradeNumber;
	dynamic tradeTime;
	dynamic type;
}

class OrderDetailItem with JsonConvert<OrderDetailItem> {
	dynamic goodsCategoryId;
	dynamic goodsCategoryName;
	dynamic goodsCover;
	dynamic goodsId;
	dynamic goodsName;
	List<OrderDetailItemsGoodsProperty> goodsProperties;
	dynamic goodsSkuId;
	dynamic goodsType;
	dynamic lastPrice;
	dynamic num;
	dynamic orderId;
	dynamic orderItemId;
	dynamic orderSalesReturnId;
	dynamic orderSalesReturnNumber;
	dynamic orderSalesReturnStatus;
	dynamic orderSalesReturnType;
	dynamic price;
	dynamic relationClassesId;
	dynamic relationClassesNum;
	dynamic relationGrade;
	dynamic relationSchoolId;
	dynamic relationSchoolName;
	dynamic relationStudentId;
	dynamic relationStudentName;
	dynamic salesReturnType;
	dynamic sourcePrice;
	dynamic supportSalesReturn;
}

class OrderDetailItemsGoodsProperty with JsonConvert<OrderDetailItemsGoodsProperty> {
	dynamic propertyId;
	dynamic propertyName;
	dynamic propertyValue;
	dynamic propertyValueId;
}

class OrderDetailLog with JsonConvert<OrderDetailLog> {
	dynamic createTime;
	dynamic creatorId;
	dynamic creatorName;
	dynamic status;
	dynamic statusDesc;
}

class OrderDetailOrderLog with JsonConvert<OrderDetailOrderLog> {
	dynamic canalStatus;
	dynamic createTime;
	dynamic creatorId;
	dynamic creatorName;
	dynamic orderId;
	dynamic orderStatus;
}

class OrderDetailOrderSalesReturn with JsonConvert<OrderDetailOrderSalesReturn> {
	dynamic createTime;
	dynamic id;
	dynamic number;
	dynamic sourceOrderId;
	dynamic sourceOrderItemId;
	dynamic sourceOrderNumber;
	dynamic status;
	dynamic type;
}
