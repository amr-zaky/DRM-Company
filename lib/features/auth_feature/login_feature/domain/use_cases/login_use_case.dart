import 'package:dartz/dartz.dart';

import '../interface/login_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';

class LoginUseCase {
  LoginUseCase({required this.repository});
  final LoginInterface repository;

  Future<Either<CustomException, SuccessModel>> loginUser(
      {required AuthEntity entity}) async {
    return repository.loginUser(entity: entity);
  }
}
