import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

abstract class ProfileRemoteDataSourceInterface {
  Future<Either<CustomException, BaseModel>> getProfileData();

  Future<Either<CustomException, BaseModel>> removeProfilePhone();

  Future<Either<CustomException, BaseModel>> updateProfileData({
    required AuthEntity entity,
  });
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getProfileData() async {
    try {
      const String url = ApiKeys.profileKey;

      final Response<dynamic> response = await DioHelper.getDate(url: url);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> updateProfileData({
    required AuthEntity entity,
  }) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.clear();
      const String pathUrl = ApiKeys.updateProfileKey;
      staticData.fields.add(MapEntry<String, String>('name', entity.name!));
      if (entity.email != null) {
        staticData.fields.add(MapEntry<String, String>('email', entity.email!));
      }

      if (entity.imageXFile != null) {
        staticData.files.add(MapEntry<String, MultipartFile>(
            'image',
            await MultipartFile.fromFile(
              entity.imageXFile!.path,
              filename: entity.imageXFile!.path.split("/").last,
            )));
      }
      final Response<dynamic> response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      print(response.data);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> removeProfilePhone() async {
    try {
      const String url = ApiKeys.deletePhotoProfileKey;

      final Response<dynamic> response = await DioHelper.getDate(url: url);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
