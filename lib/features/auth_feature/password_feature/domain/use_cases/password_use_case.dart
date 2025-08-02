import 'package:dartz/dartz.dart';

import '../interface/password_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

class PasswordUseCases {
  PasswordUseCases(this.passwordRepositoryInterface);
  final PasswordRepositoryInterface passwordRepositoryInterface;

  Future<Either<CustomException, BaseModel>> resetPassword(
      {required AuthEntity passwordAuthEntity}) {
    return passwordRepositoryInterface.resetPassword(
        passwordAuthEntity: passwordAuthEntity);
  }

  Future<Either<CustomException, BaseModel>> changePassword(
      {required AuthEntity passwordAuthEntity}) {
    return passwordRepositoryInterface.changePassword(
        passwordAuthEntity: passwordAuthEntity);
  }

  Future<Either<CustomException, BaseModel>> checkPassword(
      {required String password}) {
    return passwordRepositoryInterface.checkPassword(password: password);
  }
}
