import '/core/error_handling/custom_exception.dart';

abstract class NotificationStates {}

class NotificationStateInit extends NotificationStates {}

class NotificationLoadingState extends NotificationStates {}

class NotificationLoadingMoreDateState extends NotificationStates {}

class NotificationEmptyState extends NotificationStates {}

class NotificationSuccessState extends NotificationStates {}

class NotificationSuccessMoreDateState extends NotificationStates {}

class NotificationErrorMoreDateState extends NotificationStates {
  NotificationErrorMoreDateState({
    this.error,
  });
  CustomException? error;
}

class NotificationErrorState extends NotificationStates {
  NotificationErrorState({
    this.error,
  });
  CustomException? error;
}

class ClearNotificationSuccessState extends NotificationStates {}

class ReadORDeleteNotificationLoadingState extends NotificationStates {
  ReadORDeleteNotificationLoadingState(this.notificationID);
  final int notificationID;
}

class ReadNotificationSuccessState extends NotificationStates {}

class ReadNotificationErrorState extends NotificationStates {
  ReadNotificationErrorState({
    this.error,
  });
  CustomException? error;
}

class DeleteNotificationLoadingState extends NotificationStates {}

class DeleteNotificationSuccessState extends NotificationStates {}

class DeleteNotificationErrorState extends NotificationStates {
  DeleteNotificationErrorState({
    this.error,
  });
  CustomException? error;
}

class EnableOrDisableNotificationLoadingState extends NotificationStates {}

class EnableOrDisableNotificationSuccessState extends NotificationStates {}

class EnableOrDisableNotificationErrorState extends NotificationStates {
  EnableOrDisableNotificationErrorState({
    this.error,
  });
  CustomException? error;
}
