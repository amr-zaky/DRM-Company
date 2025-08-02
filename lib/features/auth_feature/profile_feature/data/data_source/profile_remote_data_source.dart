import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';
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
      Map<String, dynamic> map = <String, dynamic>{};
      if (entity.products!.isNotEmpty) {
        map = <String, dynamic>{
          "products": entity.products?.map((SelectableModel element) {
            return element.id ?? 0;
          }).toList()
        };
      }
      print("map: $map");

      final FormData staticData =
          FormData.fromMap(map, ListFormat.multiCompatible);
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

      print("map: ${staticData.fields}");
      print("map: ${staticData.files}");

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
