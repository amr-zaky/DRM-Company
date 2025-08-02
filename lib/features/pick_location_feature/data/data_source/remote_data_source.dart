import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/data_source/network/dio_map_helper.dart';
import '../../../../core/error_handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class MapRemoteDataSourceInterface {
  Future<Either<CustomException, BaseModel>> getAutocomplete(
      {required String search});

  Future<Either<CustomException, BaseModel>> getPlace(
      {required String placeId});
}

class MapRemoteDataSourceImpl extends MapRemoteDataSourceInterface {
  final String _key = 'AIzaSyDdCKbWxRcIdU1_L4Ckwl_40OgOfNs7AoQ';

  @override
  Future<Either<CustomException, BaseModel>> getAutocomplete(
      {required String search}) async {
    try {
      final String url =
          '/autocomplete/json?input=$search&types=(cities)&key=$_key';

      final Response<dynamic> response = await DioMapHelper.getDate(
        url: url,
      );
      print("response.data${response.data} ");
      return right(BaseModel(data: response.data['predictions']));
    } on CustomException catch (ex) {
      return left(CustomException(
        ex.type,
        errorMassage: ex.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getPlace(
      {required String placeId}) async {
    try {
      final String url = '/details/json?place_id=$placeId&key=$_key';

      final Response<dynamic> response = await DioMapHelper.getDate(
        url: url,
      );
      return right(BaseModel(data: response.data['result']));
    } on CustomException catch (ex) {
      return left(CustomException(
        ex.type,
        errorMassage: ex.errorMassage,
      ));
    }
  }
}
