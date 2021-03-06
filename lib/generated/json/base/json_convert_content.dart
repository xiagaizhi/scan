// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:scan/model/web_qr_code_data.dart';
import 'package:scan/generated/json/web_qr_code_data_helper.dart';
import 'package:scan/model/code_entity.dart';
import 'package:scan/generated/json/code_entity_helper.dart';
import 'package:scan/model/order_data.dart';
import 'package:scan/generated/json/order_data_helper.dart';
import 'package:scan/model/user_info_entity.dart';
import 'package:scan/generated/json/user_info_entity_helper.dart';
import 'package:scan/model/edit_order_data.dart';
import 'package:scan/generated/json/edit_order_data_helper.dart';
import 'package:scan/model/secret_entity.dart';
import 'package:scan/generated/json/secret_entity_helper.dart';
import 'package:scan/model/result_data.dart';
import 'package:scan/generated/json/result_data_helper.dart';
import 'package:scan/model/order_detail_data.dart';
import 'package:scan/generated/json/order_detail_data_helper.dart';
import 'package:scan/model/express_data_entity.dart';
import 'package:scan/generated/json/express_data_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case WebQrCodeData:
			return webQrCodeDataFromJson(data as WebQrCodeData, json) as T;			case CodeBeanEntity:
			return codeBeanEntityFromJson(data as CodeBeanEntity, json) as T;			case CodeBeanData:
			return codeBeanDataFromJson(data as CodeBeanData, json) as T;			case OrderData:
			return orderDataFromJson(data as OrderData, json) as T;			case UserInfoEntity:
			return userInfoEntityFromJson(data as UserInfoEntity, json) as T;			case UserInfoUserRelation:
			return userInfoUserRelationFromJson(data as UserInfoUserRelation, json) as T;			case EditOrderData:
			return editOrderDataFromJson(data as EditOrderData, json) as T;			case SecretEntity:
			return secretEntityFromJson(data as SecretEntity, json) as T;			case ResultData:
			return resultDataFromJson(data as ResultData, json) as T;			case OrderDetailData:
			return orderDetailDataFromJson(data as OrderDetailData, json) as T;			case OrderDetailItem:
			return orderDetailItemFromJson(data as OrderDetailItem, json) as T;			case OrderDetailItemsGoodsProperty:
			return orderDetailItemsGoodsPropertyFromJson(data as OrderDetailItemsGoodsProperty, json) as T;			case OrderDetailLog:
			return orderDetailLogFromJson(data as OrderDetailLog, json) as T;			case OrderDetailOrderLog:
			return orderDetailOrderLogFromJson(data as OrderDetailOrderLog, json) as T;			case OrderDetailOrderSalesReturn:
			return orderDetailOrderSalesReturnFromJson(data as OrderDetailOrderSalesReturn, json) as T;			case ExpressData:
			return expressDataFromJson(data as ExpressData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case WebQrCodeData:
			return webQrCodeDataToJson(data as WebQrCodeData);			case CodeBeanEntity:
			return codeBeanEntityToJson(data as CodeBeanEntity);			case CodeBeanData:
			return codeBeanDataToJson(data as CodeBeanData);			case OrderData:
			return orderDataToJson(data as OrderData);			case UserInfoEntity:
			return userInfoEntityToJson(data as UserInfoEntity);			case UserInfoUserRelation:
			return userInfoUserRelationToJson(data as UserInfoUserRelation);			case EditOrderData:
			return editOrderDataToJson(data as EditOrderData);			case SecretEntity:
			return secretEntityToJson(data as SecretEntity);			case ResultData:
			return resultDataToJson(data as ResultData);			case OrderDetailData:
			return orderDetailDataToJson(data as OrderDetailData);			case OrderDetailItem:
			return orderDetailItemToJson(data as OrderDetailItem);			case OrderDetailItemsGoodsProperty:
			return orderDetailItemsGoodsPropertyToJson(data as OrderDetailItemsGoodsProperty);			case OrderDetailLog:
			return orderDetailLogToJson(data as OrderDetailLog);			case OrderDetailOrderLog:
			return orderDetailOrderLogToJson(data as OrderDetailOrderLog);			case OrderDetailOrderSalesReturn:
			return orderDetailOrderSalesReturnToJson(data as OrderDetailOrderSalesReturn);			case ExpressData:
			return expressDataToJson(data as ExpressData);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'WebQrCodeData':
			return WebQrCodeData().fromJson(json);			case 'CodeBeanEntity':
			return CodeBeanEntity().fromJson(json);			case 'CodeBeanData':
			return CodeBeanData().fromJson(json);			case 'OrderData':
			return OrderData().fromJson(json);			case 'UserInfoEntity':
			return UserInfoEntity().fromJson(json);			case 'UserInfoUserRelation':
			return UserInfoUserRelation().fromJson(json);			case 'EditOrderData':
			return EditOrderData().fromJson(json);			case 'SecretEntity':
			return SecretEntity().fromJson(json);			case 'ResultData':
			return ResultData().fromJson(json);			case 'OrderDetailData':
			return OrderDetailData().fromJson(json);			case 'OrderDetailItem':
			return OrderDetailItem().fromJson(json);			case 'OrderDetailItemsGoodsProperty':
			return OrderDetailItemsGoodsProperty().fromJson(json);			case 'OrderDetailLog':
			return OrderDetailLog().fromJson(json);			case 'OrderDetailOrderLog':
			return OrderDetailOrderLog().fromJson(json);			case 'OrderDetailOrderSalesReturn':
			return OrderDetailOrderSalesReturn().fromJson(json);			case 'ExpressData':
			return ExpressData().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'WebQrCodeData':
			return List<WebQrCodeData>();			case 'CodeBeanEntity':
			return List<CodeBeanEntity>();			case 'CodeBeanData':
			return List<CodeBeanData>();			case 'OrderData':
			return List<OrderData>();			case 'UserInfoEntity':
			return List<UserInfoEntity>();			case 'UserInfoUserRelation':
			return List<UserInfoUserRelation>();			case 'EditOrderData':
			return List<EditOrderData>();			case 'SecretEntity':
			return List<SecretEntity>();			case 'ResultData':
			return List<ResultData>();			case 'OrderDetailData':
			return List<OrderDetailData>();			case 'OrderDetailItem':
			return List<OrderDetailItem>();			case 'OrderDetailItemsGoodsProperty':
			return List<OrderDetailItemsGoodsProperty>();			case 'OrderDetailLog':
			return List<OrderDetailLog>();			case 'OrderDetailOrderLog':
			return List<OrderDetailOrderLog>();			case 'OrderDetailOrderSalesReturn':
			return List<OrderDetailOrderSalesReturn>();			case 'ExpressData':
			return List<ExpressData>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}