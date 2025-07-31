import 'package:dartz/dartz.dart';

import '../../domain/interface/login_interface.dart';
import '../data_source/login_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/auth_base_model.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class LoginRepository extends LoginInterface {
  LoginRepository(
      {required this.auhLocalDataSourceInterface,
      required this.authRemoteDataSourceInterface,
      required this.connectionCheckerInterface});

  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final LoginRemoteDataSourceInterface authRemoteDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  /// login user to app
  @override
  Future<Either<CustomException, SuccessModel>> loginUser(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          ///login user in remote data source
          return authRemoteDataSourceInterface.loginUser(entity: entity).then(
              (Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException failure) {
                    return left(failure);
                  }, (BaseModel success) async {
                    ///save user token and cash your data
                    final AuthBaseModel user =
                        AuthBaseModel.fromJson(success.data['customer']);
                    user.token = success.data['token'];

                    authRemoteDataSourceInterface.saveAuthToken(
                        token: user.token!);

                    ///save the user model in cache
                    return updateCachedUserData(user);
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  Future<Either<CustomException, SuccessModel>> updateCachedUserData(
      AuthBaseModel user) async {
    try {
      return auhLocalDataSourceInterface.setCachedUser(user).then((bool value) {
        SharedText.currentUser = user;
        SharedText.userToken = user.token!;
        return right(SuccessModel());
      });
    } catch (e) {
      return left(CustomException(CustomStatusCodeErrorType.unExcepted));
    }
  }
}
