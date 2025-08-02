import '../constants/enums/exception_enums.dart';
import '../error_handling/custom_exception.dart';

List<ReasonModel> reasonListFromJson(List<dynamic> str) =>
    List<ReasonModel>.from(str.map((dynamic x) => ReasonModel.fromJson(x)));

class ReasonModel {
  ReasonModel({this.id, this.title, this.isDescribed, this.note});

  factory ReasonModel.fromJson(Map<String, dynamic> json) {
    try {
      return ReasonModel(
        id: json['id'],
        title: json['name'],
        isDescribed: json['is_described'] ?? false,
        note: json['note'] ?? "---",
      );
    } catch (ex) {
      throw CustomException(CustomStatusCodeErrorType.parsing,
          errorMassage: ex.toString());
    }
  }

  int? id;
  String? title;
  bool? isDescribed;
  String? note;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"id": id.toString(), "title": title};
}
