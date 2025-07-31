import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class PhoneInterface {
  Future<Either<CustomException, BaseModel>> changePhoneNumber(
      {required AuthEntity entity});
}
