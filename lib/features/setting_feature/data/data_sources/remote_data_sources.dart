import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class SettingRemoteDataSourceInterface {
  Future<Either<CustomException, BaseModel>> getSettingData();

  Future<Either<CustomException, BaseModel>> getSettingDataByPage(
      String pageName);
}

class SettingRemoteDataSourceImpl extends SettingRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getSettingData() async {
    try {
      const String pathUrl = ApiKeys.settingKey;

      final Response<dynamic> response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getSettingDataByPage(
      String pageName) async {
    try {
      final Response<dynamic> response = await DioHelper.getDate(url: pageName);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
