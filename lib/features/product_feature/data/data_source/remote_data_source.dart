import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

abstract class ProductRemoteDataScoursInterface {
  Future<Either<CustomException, BaseModel>> getProductList(
      {required int page, int? limit});
}

class ProductRemoteDataScoursImp extends ProductRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, BaseModel>> getProductList(
      {required int page, int? limit}) async {
    try {
      String questionUrl;
      if (limit == null) {
        questionUrl = '${ApiKeys.productKey}?page=$page';
      } else {
        questionUrl = '${ApiKeys.productKey}?page=$page&limit=$limit';
      }
      final Response<dynamic> response =
          await DioHelper.getDate(url: questionUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
