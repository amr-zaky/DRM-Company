import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/base_urls.dart';
import '../../constants/enums/exception_enums.dart';
import '../../error_handling/custom_exception.dart';
import '../../error_handling/dio_exception.dart';

class DioHelper {
  static late Dio dio;

  /// Initializing dio baseUrl
  static void init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: BaseUrls.masterUrl,
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
      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
      );
    }
  }

  ///use this method to get data from api
  static Future<Response<dynamic>> getDate({required String url}) async {
    try {
      debugPrint('user token: ${dio.options.headers}');
      return await dio.get(url);
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      debugPrint('''here is the error from dio get data:
           ${exception.response?.data["message"]}''');
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;
      final String errorMessage =
          DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, errorMassage: errorMessage);
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
      );
    }
  }

  ///use this method to send data to api
  static Future<Response<dynamic>> postData(
      {required String url, required FormData data}) async {
    try {
      debugPrint('user token: ${dio.options.headers}');
      final Response<dynamic> response = await dio.post(url, data: data);

      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioException catch (exception) {
      debugPrint('''here is the error from dio post data:
           ${exception.response?.data["message"]}''');

      /// G1et custom massage for the exception
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;

      final String errorMessage =
          DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, errorMassage: errorMessage);
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
      );
    }
  }

  ///use this method to update data in api
  static Future<Response<dynamic>> putData(
      {required String url, required FormData data}) async {
    try {
      debugPrint(dio.options.headers.toString());

      final Response<dynamic> response = await dio.put(url, data: data);
      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioException catch (exception) {
      debugPrint('''here is the error from dio put data:
           ${exception.response?.data["message"]}''');

      /// G1et custom massage for the exception
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;

      final String errorMessage =
          DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, errorMassage: errorMessage);
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
      );
    }
  }

  ///use this method to delete data in api
  static Future<Response<dynamic>> deleteData({required String url}) async {
    try {
      final Response<dynamic> response = await dio.delete(url);
      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioException catch (exception) {
      debugPrint('''here is the error from dio delete data:
           ${exception.response?.data["message"]}''');

      /// G1et custom massage for the exception
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;

      final String errorMessage =
          DioExceptions.fromDioError(exception).errorMassage;
      if (DioExceptions.fromDioError(exception).errorType !=
          CustomStatusCodeErrorType.unVerified) {}

      /// throw custom exception
      throw CustomException(errorType, errorMassage: errorMessage);
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
      );
    }
  }

  static void saveUserTokenInHeader(String token) {
    dio.options.headers
        .addAll(<String, dynamic>{"Authorization": "Bearer $token"});
  }

  static void deleteUserTokenFromHeader() {
    dio.options.headers.remove("Authorization");
  }
}
