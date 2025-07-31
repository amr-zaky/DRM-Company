import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class AddressRemoteDataScoursInterface {
  Future<Either<CustomException, BaseModel>> getAddressList(
      {required int page, int? limit});

  Future<Either<CustomException, BaseModel>> addNewAddress({
    required double lat,
    required double lng,
    required String addressName,
    required String fullAddress,
    int? isDefault,
  });
}

class AddressRemoteDataScoursImp extends AddressRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, BaseModel>> getAddressList(
      {required int page, int? limit}) async {
    try {
      String questionUrl;
      if (limit == null) {
        questionUrl = '${ApiKeys.addressKey}?page=$page';
      } else {
        questionUrl = '${ApiKeys.addressKey}?page=$page&limit=$limit';
      }
      final Response<dynamic> response =
          await DioHelper.getDate(url: questionUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> addNewAddress({
    required double lat,
    required double lng,
    required String addressName,
    required String fullAddress,
    int? isDefault,
  }) async {
    try {
      String questionUrl;
      questionUrl = ApiKeys.addressKey;
      final Map<String, dynamic> map = <String, dynamic>{
        "lat": lat,
        "lng": lng,
        "location": fullAddress,
        "name": addressName,
        "is_default": isDefault
      };

      final FormData formData = FormData.fromMap(
        map,
        ListFormat.multiCompatible,
      );
      final Response<dynamic> response = await DioHelper.postData(
        url: questionUrl,
        data: formData,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
