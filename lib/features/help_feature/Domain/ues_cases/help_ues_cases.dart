import 'package:dartz/dartz.dart';

import '../model/faq_model.dart';
import '../repository/help_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class HelpUesCases {
  HelpUesCases(this.repositoryInterface);
  final HelpInterface repositoryInterface;

  Future<Either<CustomException, List<FAQModel>>> getQuestionList(
      {required int page, int? limit}) {
    return repositoryInterface
        .getQuestionList(page: page, limit: limit ?? 10)
        .then((Either<CustomException, BaseModel> value) => value.fold(
            (CustomException l) => left(l),
            (BaseModel r) => right(questionListFromJson(r.data))));
  }

  Future<Either<CustomException, SuccessModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) {
    return repositoryInterface.addContact(
      name: name,
      email: email,
      phone: phone,
      subject: subject,
      message: message,
    );
  }
}
