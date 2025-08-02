import 'package:dartz/dartz.dart';

import '../interface/signup_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';

class SignUpUseCase {
  SignUpUseCase({required this.repository});
  final SignUpInterface repository;

  Future<Either<CustomException, SuccessModel>> singUpUser(
      {required AuthEntity entity}) async {
    return repository.singUpUser(entity: entity).then(
        (Either<CustomException, SuccessModel> value) =>
            value.fold((CustomException failure) {
              return left(failure);
            }, (SuccessModel success) {
              return right(success);
            }));
  }
}
