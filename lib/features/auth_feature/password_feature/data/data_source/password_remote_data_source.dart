import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class PasswordRemoteDataSourceInterface {
  ///change password
  Future<Either<CustomException, BaseModel>> changePassword(
      {required AuthEntity passwordAuthEntity});

  ///reset password
  Future<Either<CustomException, BaseModel>> resetPassword(
      {required AuthEntity passwordAuthEntity});

  ///Check password
  Future<Either<CustomException, BaseModel>> checkPassword(
      {required String password});
}

class PasswordRemoteDataSourceImpl extends PasswordRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> changePassword(
      {required AuthEntity passwordAuthEntity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.changePasswordKey;
      staticData.fields.add(
        MapEntry<String, String>(
            'password', passwordAuthEntity.newPassword!),
      );
      staticData.fields.add(MapEntry<String, String>(
          'password_confirmation', passwordAuthEntity.confirmPassword!));
      staticData.fields.add(
        MapEntry<String, String>('old_password', passwordAuthEntity.password!),
      );

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> resetPassword(
      {required AuthEntity passwordAuthEntity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.resetPasswordKey;
      staticData.fields.add(MapEntry<String, String>(
          'password', passwordAuthEntity.newPassword!));
      staticData.fields.add(MapEntry<String, String>(
          'password_confirmation', passwordAuthEntity.confirmPassword!));
      staticData.fields.add(MapEntry<String, String>(
          'phone', passwordAuthEntity.userCredential!));
      staticData.fields
          .add(MapEntry<String, String>('otp_code', passwordAuthEntity.otp!));
      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> checkPassword(
      {required String password}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkPasswordKey;
      staticData.fields.add(MapEntry<String, String>('password', password));

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
