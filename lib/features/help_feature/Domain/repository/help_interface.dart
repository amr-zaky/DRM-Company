import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

abstract class HelpInterface {
  Future<Either<CustomException, BaseModel>> getQuestionList(
      {required int page, int? limit});

  Future<Either<CustomException, BaseModel>> getAnswer(
      {required int questionId, required int page, int? limit});

  Future<Either<CustomException, SuccessModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  });
}
