import 'package:dartz/dartz.dart';

import '../model/notification_model.dart';
import '../repository/notification_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class NotificationUesCases {
  NotificationUesCases(this.repositoryInterface);
  final NotificationListRepositoryInterface repositoryInterface;

  Future<Either<CustomException, List<NotificationModel>>>
      getListOfNotification({required int page}) {
    return repositoryInterface.getNotificationList(page: page).then(
        (Either<CustomException, BaseModel> value) => value.fold(
            (CustomException l) => left(l),
            (BaseModel r) => right(notificationListFromJson(r.data))));
  }

  Future<Either<CustomException, SuccessModel>> clearAllNotification() {
    return repositoryInterface.clearAllNotification();
  }

  Future<Either<CustomException, SuccessModel>> readNotification(
      {required int notificationID}) {
    return repositoryInterface.markNotificationAsRead(
        notificationId: notificationID);
  }

  Future<Either<CustomException, SuccessModel>> toggleNotificationState(
      {required bool state}) {
    return repositoryInterface.stopOrPauseNotification(state: state);
  }

  Future<Either<CustomException, SuccessModel>> deleteNotification(
      {required int notificationID}) {
    return repositoryInterface.deleteNotification(
      notificationId: notificationID,
    );
  }
}
