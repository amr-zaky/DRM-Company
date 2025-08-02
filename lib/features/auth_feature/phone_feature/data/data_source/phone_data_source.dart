import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class PhoneDataSource {
  Future<Either<CustomException, BaseModel>> changePhoneNumber(
      {required AuthEntity entity});
}

class PhoneDataSourceImpl extends PhoneDataSource {
  @override
  Future<Either<CustomException, BaseModel>> changePhoneNumber(
      {required AuthEntity entity}) async {
    try {
      const String url = ApiKeys.changePhoneKey;

      final FormData formData = FormData();
      formData.fields.add(
        MapEntry<String, String>('phone', entity.phone!),
      );
      formData.fields.add(
        MapEntry<String, String>('new_phone', entity.newPhone!),
      );
      formData.fields.add(
        MapEntry<String, String>('password', entity.password!),
      );formData.fields.add(
        MapEntry<String, String>('password_confirmation', entity.password!),
      );

      final Response<dynamic> response =
          await DioHelper.postData(url: url, data: formData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
