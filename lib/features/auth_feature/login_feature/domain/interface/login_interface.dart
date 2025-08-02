import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';

abstract class LoginInterface {
  ///User login
  Future<Either<CustomException, SuccessModel>> loginUser(
      {required AuthEntity entity});
}
