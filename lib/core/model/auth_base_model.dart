import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';
import 'package:base_project_repo/core/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import '../constants/enums/exception_enums.dart';
import '../error_handling/custom_exception.dart';
import 'auth_base_entity.dart';

class AuthBaseModel extends AuthEntity {
  AuthBaseModel({
    super.name,
    super.email,
    super.phone,
    super.active,
    super.verified,
    super.id,
    super.image,
    super.otp,
    super.deviceToken,
    super.token,
    super.idCardNumber,
    super.taxNumber,
    super.companyNumber,
    super.products,
  });

  factory AuthBaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return AuthBaseModel(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        active: json["active"],
        verified: json["verified"],
        id: json["id"],
        image: json["image"] ?? '',
        otp: json["otp"],
        token: json["token"] ?? '',
        taxNumber: json["token"] ?? '',
        companyNumber: json["tax_number"] ?? '',
        idCardNumber: json["document_number"].toString(),
        products: json["products"] != null
            ? productListFromJson(json["products"])
            : <SelectableModel>[],
      );
    } catch (e) {
      debugPrint("here is the error in parsing UserBaseModel $e");
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'active': active,
        'verified': verified,
        'id': id,
        'image': image,
        'otp': otp,
        'card_number': idCardNumber,
        'token': token,
        'document_number': companyNumber,
        'tax_number': taxNumber,
      };
}
