import 'package:dio/dio.dart';

import '../../constants/base_urls.dart';
import '../../constants/enums/exception_enums.dart';
import '../../error_handling/custom_exception.dart';
import '../../error_handling/dio_exception.dart';

class DioMapHelper {
  static late Dio dio;

  /// Initializing dio map baseUrl
  static init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: BaseUrls.mapPlaceUrl,
          headers: <String, dynamic>{'Accept': 'application/json'},
          receiveDataWhenStatusError: true,
        ),
      );
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      final CustomStatusCodeErrorType errorMessage =
          DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(
        errorMessage,
      );
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted,
          errorMassage: e.toString());
    }
  }

  ///use this method to get data from google map api
  static Future<Response> getDate({required String url}) async {
    try {
      return await dio.get(url);
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;
      final String errorMessage =
          DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, errorMassage: errorMessage);
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted,
          errorMassage: e.toString());
    }
  }
}
