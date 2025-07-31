import 'package:dartz/dartz.dart';

import '../../domain/interface/signup_interface.dart';
import '../data_source/sign_up_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class SignUpRepository extends SignUpInterface {
  SignUpRepository(
      {required this.remoteDataSourceInterface,
      required this.connectionCheckerInterface});
  final SignUphRemoteDataSourceInterface remoteDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  /// singUp user to app
  @override
  Future<Either<CustomException, SuccessModel>> singUpUser(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface.userSingUp(entity: entity).then(
              (Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(SuccessModel())));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
