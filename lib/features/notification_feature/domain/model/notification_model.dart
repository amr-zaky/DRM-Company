import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<NotificationModel> notificationListFromJson(List<dynamic> str) =>
    List<NotificationModel>.from(
      str.map(
        (dynamic x) => NotificationModel.fromJson(x),
      ),
    );

class NotificationModel {
  NotificationModel({
    this.createdAt,
    this.id,
    this.isRead,
    this.icon,
    this.title,
    this.description,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        icon: json["url"] ?? "",
        isRead: json["is_read"] == 1,
        createdAt: json["date"],
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  int? id;
  String? title;
  String? description;
  String? icon;
  bool? isRead;
  String? createdAt;
}
