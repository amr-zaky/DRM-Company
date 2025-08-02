import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class ProfileInterface {
  Future<Either<CustomException, BaseModel>> getUserProfile();

  Future<Either<CustomException, BaseModel>> removeProfilePhoto();

  Future<Either<CustomException, BaseModel>> updateUserProfile({
    required AuthEntity entity,
  });
}
