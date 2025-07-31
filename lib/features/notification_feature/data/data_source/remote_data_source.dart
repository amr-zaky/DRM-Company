import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

abstract class NotificationRemoteDataScoursInterface {
  Future<Either<CustomException, BaseModel>> getNotificationList(
      {required int page});

  Future<Either<CustomException, SuccessModel>> clearAllNotification();

  Future<Either<CustomException, SuccessModel>> stopOrPauseNotification(
      {required bool state});

  Future<Either<CustomException, SuccessModel>> markNotificationAsRead(
      {required int notificationId});

  Future<Either<CustomException, SuccessModel>> deleteNotification(
      {required int notificationId});
}

class NotificationRemoteDataScoursImpl
    extends NotificationRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, SuccessModel>> clearAllNotification() async {
    try {
      const String notificationUrl = ApiKeys.clearNotificationKey;

      final FormData data = FormData();

      await DioHelper.postData(url: notificationUrl, data: data);
      return right(SuccessModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getNotificationList(
      {required int page}) async {
    try {
      final String notificationUrl = '${ApiKeys.notificationKey}?page=$page';
      final Response<dynamic> response =
          await DioHelper.getDate(url: notificationUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, SuccessModel>> markNotificationAsRead(
      {required int notificationId}) async {
    try {
      final String notificationUrl =
          '${ApiKeys.notificationKey}/$notificationId${ApiKeys.readNotificationKey}';
      await DioHelper.postData(url: notificationUrl, data: FormData());

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, SuccessModel>> stopOrPauseNotification(
      {required bool state}) async {
    try {
      const String notificationUrl = ApiKeys.toggleNotificationKey;
      final FormData data = FormData();
      data.fields.add(MapEntry<String, String>('status', state ? "0" : "1"));
      await DioHelper.postData(url: notificationUrl, data: data);

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, SuccessModel>> deleteNotification(
      {required int notificationId}) async {
    try {
      final String notificationUrl =
          '${ApiKeys.notificationKey}/$notificationId${ApiKeys.clearNotificationKey}';
      await DioHelper.deleteData(url: notificationUrl);

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
