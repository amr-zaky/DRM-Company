import 'package:dartz/dartz.dart';

import '../../domain/interface/logout_interface.dart';
import '../data_source/logout_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class LogoutRepository extends LogoutInterface {
  LogoutRepository(
      {required this.auhLocalDataSourceInterface,
      required this.authRemoteDataSourceInterface,
      required this.connectionCheckerInterface});
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final LogoutRemoteDataSourceInterface authRemoteDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, SuccessModel>> logOutUser() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return authRemoteDataSourceInterface.logOut().then(
              (Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException l) {
                    auhLocalDataSourceInterface.deleteCachedUser();
                    return left(l);
                  }, (BaseModel r) {
                    auhLocalDataSourceInterface.deleteCachedUser();
                    return right(SuccessModel());
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
