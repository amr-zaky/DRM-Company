import 'package:dartz/dartz.dart';

import '../interface/profile_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

class ProfileUseCases {
  ProfileUseCases(this.repositoryInterface);
  final ProfileInterface repositoryInterface;

  Future<Either<CustomException, BaseModel>> getUserProfile() {
    return repositoryInterface.getUserProfile();
  }

  Future<Either<CustomException, BaseModel>> removePhoto() {
    return repositoryInterface.removeProfilePhoto();
  }

  Future<Either<CustomException, BaseModel>> updateUserProfile(
      {required AuthEntity entity}) {
    return repositoryInterface.updateUserProfile(entity: entity);
  }
}
