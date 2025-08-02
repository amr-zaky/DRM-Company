import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../domain/repository/setting_interface.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';

class SettingRepository extends SettingRepositoryInterface {
  SettingRepository(
      {required this.remoteDataSourceInterface,
      required this.localDataSourceInterface,
      required this.connectionCheckerInterface});
  final SettingRemoteDataSourceInterface remoteDataSourceInterface;
  final SettingLocalDataSourceInterface localDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, BaseModel>> getSettingData() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataSourceInterface.getSettingData().then(
              (Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException failure) async {
                    return getCachedSetting();
                  }, (BaseModel settingData) {
                    localDataSourceInterface.setSettingMap(
                        settingMap: json.encode(settingData.toJson()));
                    return right(settingData);
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  Future<Either<CustomException, BaseModel>> getCachedSetting() async {
    try {
      final String? settingModel =
          localDataSourceInterface.getSettingMap() as String?;
      return right(BaseModel.fromJson(json.decode(settingModel!)));
    } catch (e) {
      return left(CustomException(CustomStatusCodeErrorType.unExcepted));
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getSettingDataByPage(
      String pageName) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataSourceInterface.getSettingDataByPage(pageName);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
