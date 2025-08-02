import 'package:dartz/dartz.dart';

import '../../domain/interface/password_interface.dart';
import '../data_source/password_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

class PasswordRepository extends PasswordRepositoryInterface {
  PasswordRepository(
      {required this.remoteDataSourceInterface,
      required this.connectionCheckerInterface});

  final PasswordRemoteDataSourceInterface remoteDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, BaseModel>> changePassword(
      {required AuthEntity passwordAuthEntity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.changePassword(
              passwordAuthEntity: passwordAuthEntity);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> resetPassword(
      {required AuthEntity passwordAuthEntity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.resetPassword(
              passwordAuthEntity: passwordAuthEntity);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> checkPassword(
      {required String password}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.checkPassword(password: password);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
