import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class OtpRemoteDataSourceInterface {
  ///verify account
  Future<Either<CustomException, BaseModel>> verifyAccount(
      {required AuthEntity entity});

  ///check otp
  Future<Either<CustomException, BaseModel>> checkOtp(
      {required AuthEntity entity});

  ///send otp to email
  Future<Either<CustomException, BaseModel>> sendOtp(
      {required String userCredential});

  ///resend otp
  Future<Either<CustomException, BaseModel>> resendOTP({
    required String userCredential,
  });

  void saveAuthToken({required String token});
}

class OtpRemoteDataSourceImp extends OtpRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> resendOTP(
      {required String userCredential}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.reSendOtpKey;
      staticData.fields.add(MapEntry<String, String>('phone', userCredential));

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> verifyAccount(
      {required AuthEntity entity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkAndVerifyKey;
      staticData.fields.add(
        MapEntry<String, String>('phone', entity.userCredential!),
      );
      staticData.fields.add(
        MapEntry<String, String>('otp_code', entity.otp!),
      );

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> checkOtp(
      {required AuthEntity entity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkOtpKey;
      staticData.fields
          .add(MapEntry<String, String>('phone', entity.userCredential!));
      staticData.fields.add(MapEntry<String, String>('otp_code', entity.otp!));

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> sendOtp(
      {required String userCredential}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.forgetPasswordKey;
      staticData.fields.add(
        MapEntry<String, String>('phone', userCredential),
      );

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  void saveAuthToken({required String token}) {
    DioHelper.saveUserTokenInHeader(token);
  }
}
