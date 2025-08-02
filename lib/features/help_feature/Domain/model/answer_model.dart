import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<AnswerModel> answerListFromJson(List<dynamic> str) =>
    List<AnswerModel>.from(str.map((dynamic x) => AnswerModel.fromJson(x)));

class AnswerModel {
  AnswerModel({required this.id, required this.name});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    try {
      return AnswerModel(id: json['id'], name: json['name']);
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }
  int id;
  String name;
}
