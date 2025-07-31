import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<TicketComment> ticketCommentListFromJson(List<dynamic> str) =>
    List<TicketComment>.from(str.map((dynamic x) => TicketComment.fromJson(x)));

class TicketComment {
  TicketComment({
    required this.id,
    required this.comment,
    required this.senderType,
  });

  factory TicketComment.fromJson(Map<String, dynamic> json) {
    try {
      return TicketComment(
        id: json['id'] ?? 0,
        comment: json['message'] ?? '',
        senderType: json['sender_type'] ?? '',
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }
  int id;
  String comment;
  String senderType;

  @override
  String toString() {
    return 'TicketComment{id: $id, comment: $comment, senderType: $senderType}';
  }
}
