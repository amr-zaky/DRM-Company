import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class DeleteAccountDataSource {
  Future<Either<CustomException, BaseModel>> getDeleteAccountReasons();

  Future<Either<CustomException, BaseModel>> deleteAccount(
      {required String reason, required String reasonNote});

  void deleteAuthToken();
}

class DeleteAccountDataSourceImp extends DeleteAccountDataSource {
  @override
  Future<Either<CustomException, BaseModel>> deleteAccount(
      {required String reason, required String reasonNote}) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.add(MapEntry<String, String>('closed_reason', reason));
      staticData.fields.add(MapEntry<String, String>('note', reasonNote));
      const String loginUrl = ApiKeys.deleteProfileKey;

      await DioHelper.postData(url: loginUrl, data: staticData);

      return right(BaseModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getDeleteAccountReasons() async {
    try {
      const String url = "${ApiKeys.reasonsKey}?state=delete_account";

      final Response<dynamic> response = await DioHelper.getDate(url: url);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  void deleteAuthToken() {
    DioHelper.deleteUserTokenFromHeader();
  }
}
