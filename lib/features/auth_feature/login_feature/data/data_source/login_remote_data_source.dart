import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class LoginRemoteDataSourceInterface {
  ///login user
  Future<Either<CustomException, BaseModel>> loginUser(
      {required AuthEntity entity});

  void saveAuthToken({required String token});
}

class LoginRemoteDataSourceImp extends LoginRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> loginUser(
      {required AuthEntity entity}) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.clear();
      const String loginUrl = ApiKeys.loginKey;
      staticData.fields.add(
        MapEntry<String, String>('phone', entity.userCredential!),
      );
      staticData.fields.add(
        MapEntry<String, String>('password', entity.password!),
      );
      staticData.fields.add(
        MapEntry<String, String>('device_token', entity.deviceToken!),
      );
      final Response<dynamic> response =
          await DioHelper.postData(url: loginUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  void saveAuthToken({required String token}) {
    DioHelper.saveUserTokenInHeader(token);
  }
}
