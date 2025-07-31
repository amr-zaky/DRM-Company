import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

abstract class HelpRemoteDataScoursInterface {
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

class HelpRemoteDataScoursImp extends HelpRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, SuccessModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    try {
      final FormData data = FormData();
      data.fields.add(
        MapEntry<String, String>('name', name),
      );
      data.fields.add(
        MapEntry<String, String>('email', email),
      );
      data.fields.add(
        MapEntry<String, String>('phone', phone),
      );
      data.fields.add(
        MapEntry<String, String>('subject', subject),
      );
      data.fields.add(
        MapEntry<String, String>('message', message),
      );
      await DioHelper.postData(url: ApiKeys.contactKey, data: data);

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getAnswer(
      {required int questionId, required int page, int? limit}) async {
    try {
      String answerUrl = '${ApiKeys.answerKey}?page=$page';
      if (limit == null) {
        answerUrl += '&question_id=$questionId';
      } else {
        answerUrl += '&limit=$limit&question_id=$questionId';
      }
      final Response<dynamic> response =
          await DioHelper.getDate(url: answerUrl);

      return right(
        BaseModel.fromJson(response.data),
      );
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getQuestionList(
      {required int page, int? limit}) async {
    try {
      String questionUrl;
      if (limit == null) {
        questionUrl = '${ApiKeys.questionKey}?page=$page';
      } else {
        questionUrl = '${ApiKeys.questionKey}?page=$page&limit=$limit';
      }
      final Response<dynamic> response =
          await DioHelper.getDate(url: questionUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
