import 'package:dartz/dartz.dart';

import '../interface/splash_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';

class SplashUseCase {
  SplashUseCase({required this.repository});
  final SplashInterface repository;

  Future<Either<CustomException, SuccessModel>> checkExistingUser() async {
    return repository.checkExistingUser();
  }
}
