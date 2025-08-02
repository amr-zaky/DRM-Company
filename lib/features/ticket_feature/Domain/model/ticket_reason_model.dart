import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/feature/filter_feature/domain/model/search_filter_model.dart';

List<TicketReasonModel> ticketReasonListFromJson(List<dynamic> str) =>
    List<TicketReasonModel>.from(
      str.map(
        (dynamic x) => TicketReasonModel.fromJson(x),
      ),
    );

class TicketReasonModel extends SelectableModel {
  TicketReasonModel({
    super.id,
    super.name,
    required this.categoryId,
  });

  factory TicketReasonModel.fromJson(Map<String, dynamic> json) {
    try {
      return TicketReasonModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        categoryId: json['ticket_category_id'] ?? '',
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  String categoryId;
}
