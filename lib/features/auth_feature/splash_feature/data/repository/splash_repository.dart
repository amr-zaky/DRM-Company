import 'package:dartz/dartz.dart';

import '../../domain/interface/splash_interface.dart';
import '../data_source/splash_remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/auth_base_model.dart';
import '/core/model/success_model.dart';

class SplashRepository extends SplashInterface {
  SplashRepository(
      {required this.auhLocalDataSourceInterface,
      required this.remoteDataSourceInterface});

  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final SplashRemoteDataSourceInterface remoteDataSourceInterface;

  @override
  Future<Either<CustomException, SuccessModel>> checkExistingUser() async {
    final bool result =
        await auhLocalDataSourceInterface.getIsLogged() ?? false;

    if (result) {
      return setCachedUser();
    } else {
      return left(
          CustomException(await auhLocalDataSourceInterface.getIsFirstTime()));
    }
  }

  Future<Either<CustomException, SuccessModel>> setCachedUser() async {
    final AuthBaseModel userModel =
        await auhLocalDataSourceInterface.getCachedUser();
    SharedText.currentUser = userModel;
    if (userModel.token != null && userModel.token!.isNotEmpty) {
      remoteDataSourceInterface.saveAuthToken(token: userModel.token!);
      SharedText.userToken = userModel.token!;
      return right(SuccessModel());
    } else {
      return left(CustomException(CustomStatusCodeErrorType.unExcepted));
    }
  }
}
