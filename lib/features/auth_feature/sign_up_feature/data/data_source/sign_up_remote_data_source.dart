import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class SignUphRemoteDataSourceInterface {
  ///User Create A new Account
  Future<Either<CustomException, BaseModel>> userSingUp(
      {required AuthEntity entity});
}

class SignUphRemoteDataSourceImp extends SignUphRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> userSingUp(
      {required AuthEntity entity}) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.clear();
      const String pathUrl = ApiKeys.singUpKey;
      staticData.fields.add(
        MapEntry<String, String>('name', entity.name!),
      );
      staticData.fields.add(
        MapEntry<String, String>('email', entity.email!),
      );
      staticData.fields.add(
        MapEntry<String, String>('phone', entity.phone!),
      );
      staticData.fields.add(
        MapEntry<String, String>('password', entity.password!),
      );
      staticData.fields.add(
        MapEntry<String, String>(
            'password_confirmation', entity.confirmPassword!),
      );
      staticData.fields.add(
        MapEntry<String, String>('device_token', entity.deviceToken!),
      );
      staticData.fields.add(
        MapEntry<String, String>('card_number', entity.idCardNumber!),
      );
      if (entity.image != null && entity.image != "") {
        staticData.files.add(
          MapEntry<String, MultipartFile>(
            'image',
            await MultipartFile.fromFile(
              entity.image!,
              filename: entity.image!.split("/").last,
            ),
          ),
        );
      }

      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
