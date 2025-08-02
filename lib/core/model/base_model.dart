import 'dart:convert';

import '../constants/enums/exception_enums.dart';
import '../error_handling/custom_exception.dart';

class BaseModel {
  BaseModel({this.code, this.message, this.data, this.otp});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return BaseModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] ?? [],
      );
    } catch (ex) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  int? code;

  String? message;
  String? otp;
  dynamic data;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "message": message,
        "data": data,
      };

  String baseModelToJson(BaseModel data) => json.encode(data.toJson());

  @override
  String toString() {
    return 'BaseModel{code: $code, message: $message, data: $data}';
  }
}
