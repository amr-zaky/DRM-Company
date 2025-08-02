import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<SettingSubModel> settingSubListFromJson(List<dynamic> str) =>
    List<SettingSubModel>.from(
      str.map(
        (dynamic x) => SettingSubModel.fromJson(x),
      ),
    );

Map<String, dynamic> convertSettingJsonToMap(List<dynamic> str) {
  final List<SettingSubModel> jsonList = settingSubListFromJson(str);
  final Map<String, dynamic> resultMap = <String, dynamic>{};

  for (final SettingSubModel item in jsonList) {
    resultMap[item.key] = item.value;
  }

  return resultMap;
}

class SettingSubModel {
  SettingSubModel({
    required this.id,
    required this.key,
    required this.value,
  });

  factory SettingSubModel.fromJson(Map<String, dynamic> json) {
    try {
      return SettingSubModel(
        id: json['id'],
        key: json['key'],
        value: json['value'],
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  final int id;
  final String key;
  final dynamic value;
}
