import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';

abstract class OtpRepositoryInterface {
  Future<Either<CustomException, String>> sendVerificationCode(
      {required String userCredential});

  Future<Either<CustomException, SuccessModel>> verifyAccount(
      {required AuthEntity entity});

  Future<Either<CustomException, SuccessModel>> checkOtp(
      {required AuthEntity entity});

  Future<Either<CustomException, String>> resendOTP(
      {required String userCredential});
}
