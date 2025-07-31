import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';

abstract class SplashInterface {
  Future<Either<CustomException, SuccessModel>> checkExistingUser();
}
