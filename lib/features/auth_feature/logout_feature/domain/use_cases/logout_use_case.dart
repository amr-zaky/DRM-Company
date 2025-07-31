import 'package:dartz/dartz.dart';

import '../interface/logout_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';

class LogoutUseCase {
  LogoutUseCase({required this.repository});
  final LogoutInterface repository;

  Future<Either<CustomException, SuccessModel>> logOutUser() async {
    return repository.logOutUser();
  }
}
