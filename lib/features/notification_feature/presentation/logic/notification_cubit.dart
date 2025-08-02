import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/notification_model.dart';
import '../../domain/ues_cases/notification_ues_cases.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';
import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this._repo) : super(NotificationStateInit());

  static NotificationCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final NotificationUesCases _repo;

  bool isNotified = false;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<NotificationModel> notificationList = <NotificationModel>[];
  bool hasMoreData = false;

  Future<dynamic> onRefresh() async {
    getNotificationList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! NotificationLoadingMoreDateState && hasMoreData) {
        whenScrollNotificationPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollNotificationPagination() async {
    emit(NotificationLoadingMoreDateState());

    page = page + 1;
    final Either<CustomException, List<NotificationModel>> result =
        await _repo.getListOfNotification(page: page);
    result.fold(
        (CustomException error) =>
            emit(NotificationErrorMoreDateState(error: error)),
        (List<NotificationModel> notificationListData) {
      final List<NotificationModel> tempList = notificationListData;
      hasMoreData = tempList.length == 10;
      notificationList.addAll(tempList);
      emit(NotificationSuccessMoreDateState());
    });
  }

  /// Get All notification List
  void getNotificationList() async {
    emit(NotificationLoadingState());
    page = 1;
    final Either<CustomException, List<NotificationModel>> result =
        await _repo.getListOfNotification(page: page);
    result.fold((CustomException error) => emit(NotificationErrorState()),
        (List<NotificationModel> notificationListData) {
      notificationList = notificationListData;
      hasMoreData = notificationList.length == 10;
      if (notificationList.isEmpty) {
        emit(NotificationEmptyState());
      } else {
        emit(NotificationSuccessState());
      }
    });
  }

  /// clear All notification List
  void clearAllNotificationList() async {
    emit(NotificationLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _repo.clearAllNotification();
    result.fold(
        (CustomException error) => emit(NotificationErrorState(
              error: error,
            )),
        (SuccessModel r) => emit(ClearNotificationSuccessState()));
  }

  /// delete notification
  void deleteNotificationList({required int notificationId}) async {
    emit(ReadORDeleteNotificationLoadingState(notificationId));
    final Either<CustomException, SuccessModel> result =
        await _repo.deleteNotification(notificationID: notificationId);
    result.fold(
        (CustomException error) => emit(DeleteNotificationErrorState(
              error: error,
            )), (SuccessModel r) {
      notificationList.removeWhere(
          (NotificationModel element) => element.id == notificationId);
      emit(DeleteNotificationSuccessState());
    });
  }

  /// mark notification as read
  void readNotification({required int notificationId}) async {
    emit(ReadORDeleteNotificationLoadingState(notificationId));
    final Either<CustomException, SuccessModel> result =
        await _repo.readNotification(notificationID: notificationId);
    result.fold(
        (CustomException error) => emit(ReadNotificationErrorState(
              error: error,
            )), (SuccessModel r) {
      for (final NotificationModel element in notificationList) {
        if (element.id == notificationId) {
          element.isRead = true;
        }
      }
      emit(ReadNotificationSuccessState());
    });
  }

  ///Enable or disable notification
  void enableOrDisableNotification() async {
    emit(EnableOrDisableNotificationLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _repo.toggleNotificationState(state: isNotified);
    result.fold(
        (CustomException error) => emit(EnableOrDisableNotificationErrorState(
              error: error,
            )), (SuccessModel r) {
      isNotified = !isNotified;
      emit(EnableOrDisableNotificationSuccessState());
    });
  }
}
