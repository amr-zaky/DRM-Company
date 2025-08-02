import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

abstract class NotificationListRepositoryInterface {
  Future<Either<CustomException, BaseModel>> getNotificationList(
      {required int page});

  Future<Either<CustomException, SuccessModel>> clearAllNotification();

  Future<Either<CustomException, SuccessModel>> markNotificationAsRead(
      {required int notificationId});

  Future<Either<CustomException, SuccessModel>> deleteNotification(
      {required int notificationId});

  Future<Either<CustomException, SuccessModel>> stopOrPauseNotification(
      {required bool state});
}
