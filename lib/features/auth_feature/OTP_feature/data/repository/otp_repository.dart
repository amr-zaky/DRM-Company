import 'package:dartz/dartz.dart';

import '../../domain/interface/otp_interface.dart';
import '../data_source/otp_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/auth_base_model.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class OtpRepository extends OtpRepositoryInterface {
  OtpRepository(
      {required this.remoteDataSourceInterface,
      required this.auhLocalDataSourceInterface,
      required this.connectionCheckerInterface});
  final OtpRemoteDataSourceInterface remoteDataSourceInterface;
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, String>> resendOTP(
      {required String userCredential}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return remoteDataSourceInterface
              .resendOTP(userCredential: userCredential)
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(r.data['otp_code'])));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> verifyAccount(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataSourceInterface.verifyAccount(entity: entity).then(
              (Either<CustomException, BaseModel> value) => value
                      .fold((CustomException l) => left(l),
                          (BaseModel success) async {
                    ///save user token and cash your data
                    final AuthBaseModel user =
                        AuthBaseModel.fromJson(success.data['customer']);
                    user.token = success.data['token'];

                    remoteDataSourceInterface.saveAuthToken(token: user.token!);

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

  @override
  Future<Either<CustomException, SuccessModel>> checkOtp(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataSourceInterface.checkOtp(entity: entity).then(
                (Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(SuccessModel()),
                ),
              );
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, String>> sendVerificationCode(
      {required String userCredential}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataSourceInterface
              .sendOtp(userCredential: userCredential)
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(r.data['otp_code'])));
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
