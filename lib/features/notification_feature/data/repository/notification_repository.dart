import 'package:dartz/dartz.dart';

import '../../domain/repository/notification_interface.dart';
import '../data_source/remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class NotificationListRepository extends NotificationListRepositoryInterface {
  NotificationListRepository(
      {required this.remoteDataScoursInterface,
      required this.connectionCheckerInterface});
  final NotificationRemoteDataScoursInterface remoteDataScoursInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, SuccessModel>> clearAllNotification() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.clearAllNotification();
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> getNotificationList(
      {required int page}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.getNotificationList(page: page);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> markNotificationAsRead(
      {required int notificationId}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.markNotificationAsRead(
              notificationId: notificationId);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> stopOrPauseNotification(
      {required bool state}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.stopOrPauseNotification(
              state: state);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> deleteNotification(
      {required int notificationId}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.deleteNotification(
              notificationId: notificationId);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
