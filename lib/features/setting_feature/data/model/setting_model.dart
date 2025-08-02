import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<String> stringListFromJson(List<dynamic> str) =>
    List<String>.from(str.map((dynamic x) => x['phone']));

class SettingModel {
  SettingModel({
    this.sitePhone,
    this.siteWhatsApp,
    this.siteEmail,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    try {
      return SettingModel(
        sitePhone: json["phone"],
        siteWhatsApp: json["whatsup"],
        siteEmail: json["email"],
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }
  String? sitePhone;
  String? siteWhatsApp;
  String? siteEmail;
}
