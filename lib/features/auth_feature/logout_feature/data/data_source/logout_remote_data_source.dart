import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class LogoutRemoteDataSourceInterface {
  ///log out
  Future<Either<CustomException, BaseModel>> logOut();

  void deleteAuthToken();
}

class LogoutRemoteDataSourceImp extends LogoutRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> logOut() async {
    try {
      final FormData staticData = FormData();

      const String loginUrl = ApiKeys.logOutKey;

      await DioHelper.postData(url: loginUrl, data: staticData);

      ///delete user token from Auth header
      deleteAuthToken();

      return right(BaseModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  void deleteAuthToken() {
    DioHelper.dio.options.headers.remove("Authorization");
  }
}
