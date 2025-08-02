import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/enums/exception_enums.dart';

class DioExceptions implements Exception {
  /// custom Exceptions message
  DioExceptions.fromDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        errorType = CustomStatusCodeErrorType.internet;
        break;
      case DioExceptionType.badResponse:
        errorMassage = exception.response!.data["message"];
        errorType = _handleErrorType(exception.response!.statusCode!);
        break;
      case DioExceptionType.badCertificate:
        errorType = CustomStatusCodeErrorType.unVerified;
        break;
      case DioExceptionType.connectionTimeout:
        errorType = CustomStatusCodeErrorType.connectTimeout;
        break;
      case DioExceptionType.unknown:
        debugPrint("error is ${exception.type} ");
        errorType = CustomStatusCodeErrorType.unExcepted;
        break;
      case DioExceptionType.receiveTimeout:
        errorType = CustomStatusCodeErrorType.receiveTimeout;
        break;
      case DioExceptionType.connectionError:
        errorType = CustomStatusCodeErrorType.server;
        break;
      case DioExceptionType.sendTimeout:
        errorType = CustomStatusCodeErrorType.sendTimeout;
        break;
      default:
        debugPrint('code ${exception.response!.statusCode}');
        errorType = _handleErrorType(exception.response!.statusCode!);
        errorMassage = exception.response!.data["message"];
        break;
    }
  }

  late CustomStatusCodeErrorType errorType;
  String errorMassage = "";

  /// custom response statusCode massage
  CustomStatusCodeErrorType _handleErrorType(int statusCode) {
    debugPrint('CustomStatusCodeErrorType: $statusCode');
    switch (statusCode) {
      case 400:
        return CustomStatusCodeErrorType.badRequest;
      case 401:
        return CustomStatusCodeErrorType.unVerified;
      case 404:
        return CustomStatusCodeErrorType.notFound;
      case 500:
        return CustomStatusCodeErrorType.server;
      case 502:
        return CustomStatusCodeErrorType.badRequest;
      case 302:
        return CustomStatusCodeErrorType.redirection;
      default:
        return CustomStatusCodeErrorType.unExcepted;
    }
  }

  @override
  String toString() => '$errorType';
}
