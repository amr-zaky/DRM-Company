import '/core/data_source/network/dio_helper.dart';

abstract class SplashRemoteDataSourceInterface {
  void saveAuthToken({required String token});
}

class SplashRemoteDataSourceImp extends SplashRemoteDataSourceInterface {
  @override
  void saveAuthToken({required String token}) {
    DioHelper.saveUserTokenInHeader(token);
  }
}
