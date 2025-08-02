import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/model/address_model.dart';
import 'package:base_project_repo/core/model/auth_base_model.dart';
import 'package:base_project_repo/core/model/product_model.dart';

import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<OrderModel> orderListFromJson(List<dynamic> str) =>
    List<OrderModel>.from(str.map((dynamic x) => OrderModel.fromJson(json: x)));

class OrderModel {
  OrderModel(
      {required this.id,
      required this.status,
      required this.date,
      required this.tax,
      required this.productModel,
      this.provider,
      required this.addressModel,
      required this.quantity,
      required this.account,
      required this.total});

  factory OrderModel.fromJson({required Map<String, dynamic> json}) {
    try {
      return OrderModel(
          id: json['id'],
          addressModel: AddressModel.fromJson(json['account_address']),
          productModel: ProductModel.fromJson(json['product']),
          provider: json['provider'] != null
              ? AuthBaseModel.fromJson(json['provider'])
              : null,
          total: num.tryParse(json["total_price"]) ?? 0,
          status: OrderStatus.newStatus.getStatusValueInModel(json['status']),
          date: json['date'],
          quantity: json["quantity"],
          tax: num.tryParse(json['tax'].toString()) ?? 0,
          account: AuthBaseModel.fromJson(json["account"]));
    } catch (ex) {
      throw CustomException(CustomStatusCodeErrorType.parsing,
          errorMassage: "OrderModel Error In Parse: $ex");
    }
  }

  int id;
  AuthBaseModel account;
  AuthBaseModel? provider;
  AddressModel addressModel;
  ProductModel productModel;
  num total;
  num quantity;
  OrderStatus status;
  String date;
  num tax;
}
