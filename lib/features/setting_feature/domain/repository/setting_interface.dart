import 'package:dartz/dartz.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class SettingRepositoryInterface {
  Future<Either<CustomException, BaseModel>> getSettingData();
  Future<Either<CustomException, BaseModel>> getSettingDataByPage(
      String pageName);
}
