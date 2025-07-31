import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';

List<TicketModel> ticketListFromJson(List<dynamic> str) =>
    List<TicketModel>.from(str.map((dynamic x) => TicketModel.fromJson(x)));

class TicketModel {
  TicketModel({
    required this.id,
    required this.isOpen,
    required this.content,
    required this.subject,
    required this.category,
    required this.date,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    try {
      return TicketModel(
        id: json['id'] ?? 0,
        content: json['message'] ?? '',
        subject: json['title'] ?? '',
        category: json['ticket_category']['name'] ?? '',
        isOpen: json['status'].toString() == "open",
        date: DateTime.parse(json['created_at'].toString()),
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }
  int id;
  bool isOpen;
  String content;
  String subject;
  String category;
  DateTime date;

  @override
  String toString() {
    return 'TicketModel{id: $id, isOpen: $isOpen}';
  }
}
