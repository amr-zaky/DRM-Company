import 'package:dartz/dartz.dart';

import '../../domain/interface/profile_interface.dart';
import '../data_source/profile_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/auth_base_model.dart';
import '/core/model/base_model.dart';

class ProfileRepository extends ProfileInterface {
  ProfileRepository(
      {required this.remoteDataSourceInterface,
      required this.localDataSourceInterface,
      required this.connectionCheckerInterface});

  final ProfileRemoteDataSourceInterface remoteDataSourceInterface;
  final AuthLocalDataSourceInterface localDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, BaseModel>> getUserProfile() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.getProfileData().then(
              (Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException l) => left(l), (BaseModel r) {
                    cacheJsonUser(r.data);
                    return right(r);
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> updateUserProfile(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface
              .updateProfileData(entity: entity)
              .then((Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException l) => left(l), (BaseModel r) {
                    cacheJsonUser(r.data);
                    return right(r);
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> removeProfilePhoto() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.removeProfilePhone();
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  void cacheJsonUser(Map<String, dynamic> json) {
    ///save the user model in cache
    final AuthBaseModel user = AuthBaseModel.fromJson(json);
    SharedText.currentUser = user;
    localDataSourceInterface.setCachedUser(user);
  }
}
