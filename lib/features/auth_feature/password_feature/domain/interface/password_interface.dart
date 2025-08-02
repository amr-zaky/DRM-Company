import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class PasswordRepositoryInterface {
  Future<Either<CustomException, BaseModel>> resetPassword(
      {required AuthEntity passwordAuthEntity});

  Future<Either<CustomException, BaseModel>> changePassword(
      {required AuthEntity passwordAuthEntity});

  Future<Either<CustomException, BaseModel>> checkPassword(
      {required String password});
}
