import 'package:dartz/dartz.dart';

import '../../data/model/setting_model.dart';
import '../../data/model/setting_sub_model.dart';
import '../repository/setting_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

class SettingUserCase {
  SettingUserCase(this.repository);
  final SettingRepositoryInterface repository;

  Future<Either<CustomException, SettingModel>> callAppSetting() async {
    return repository.getSettingData().then(
        (Either<CustomException, BaseModel> value) => value.fold(
            (CustomException l) => left(l),
            (BaseModel settingData) => right(SettingModel.fromJson(
                convertSettingJsonToMap(settingData.data!)))));
  }

  Future<Either<CustomException, String>> callAppSettingByPage(
      String pageName) async {
    return repository.getSettingDataByPage(pageName).then(
        (Either<CustomException, BaseModel> value) => value.fold(
            (CustomException l) => left(l),
            (BaseModel data) => right(data.data['content'])));
  }
}
