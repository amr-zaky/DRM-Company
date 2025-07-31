import 'package:dartz/dartz.dart';

import '../interface/otp_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';

class OtpUseCases {
  OtpUseCases(this.repositoryInterface);
  final OtpRepositoryInterface repositoryInterface;

  Future<Either<CustomException, SuccessModel>> verifyAccount(
      {required AuthEntity entity}) {
    return repositoryInterface.verifyAccount(entity: entity);
  }

  Future<Either<CustomException, String>> resendOTP({
    required String userCredential,
  }) {
    return repositoryInterface
        .resendOTP(
          userCredential: userCredential,
        )
        .then((Either<CustomException, String> value) =>
            value.fold((CustomException failure) {
              return left(failure);
            }, (String success) {
              return right(success);
            }));
  }

  Future<Either<CustomException, SuccessModel>> checkOtp({
    required AuthEntity entity,
  }) {
    return repositoryInterface.checkOtp(entity: entity);
  }

  Future<Either<CustomException, String>> sendVerificationCode({
    required String userCredential,
  }) {
    return repositoryInterface
        .sendVerificationCode(
          userCredential: userCredential,
        )
        .then((Either<CustomException, String> value) =>
            value.fold((CustomException failure) {
              return left(failure);
            }, (String success) {
              return right(success);
            }));
  }
}
