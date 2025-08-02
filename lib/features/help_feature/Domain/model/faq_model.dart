import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<FAQModel> questionListFromJson(List<dynamic> str) =>
    List<FAQModel>.from(str.map((dynamic x) => FAQModel.fromJson(x)));

class FAQModel {
  FAQModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    try {
      return FAQModel(
        id: json['id'] ?? 0,
        question: json['question'] ?? '',
        answer: json['answer'] ?? '',
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }
  int id;
  String question;
  String answer;
}
