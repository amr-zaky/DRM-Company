import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';

abstract class LogoutInterface {
  Future<Either<CustomException, SuccessModel>> logOutUser();
}
