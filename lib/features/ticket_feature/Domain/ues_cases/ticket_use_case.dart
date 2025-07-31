import 'package:dartz/dartz.dart';

import '../model/ticket_comment_model.dart';
import '../model/ticket_model.dart';
import '../model/ticket_reason_model.dart';
import '../reposiroty/ticket_interface.dart';
import '/core/error_handling/custom_exception.dart';

class TicketUseCase {
  TicketUseCase(this._interface);

  final TicketInterface _interface;

  Future<Either<CustomException, TicketModel>> openTicket(
      {required int reasonId, required String note, required String subject}) {
    return _interface
        .openTicket(
          reasonId: reasonId,
          subject: subject,
          note: note,
        )
        .then((Either<CustomException, TicketModel> value) => value.fold(
            (CustomException error) => left(error),
            (TicketModel r) => right(r)));
  }

  Future<Either<CustomException, List<TicketModel>>> getTicketsList(
      {required int page, int? limit}) {
    return _interface.getTicketsList(page: page, limit: limit).then(
        (Either<CustomException, List<TicketModel>> value) => value.fold(
            (CustomException l) => left(l), (List<TicketModel> r) => right(r)));
  }

  Future<Either<CustomException, List<TicketComment>>> getTicketComments(
      {required String ticketId}) {
    return _interface.getTicketComments(ticketId: ticketId).then(
        (Either<CustomException, List<TicketComment>> value) => value.fold(
            (CustomException l) => left(l),
            (List<TicketComment> r) => right(r)));
  }

  Future<Either<CustomException, TicketComment>> sendComment(
      {required String ticketId, required String comment}) {
    return _interface.sendComment(ticketId: ticketId, comment: comment).then(
        (Either<CustomException, TicketComment> value) => value.fold(
            (CustomException l) => left(l), (TicketComment r) => right(r)));
  }

  Future<Either<CustomException, List<TicketReasonModel>>> getTicketCategory() {
    return _interface.getTicketCategory().then(
        (Either<CustomException, List<TicketReasonModel>> value) => value.fold(
            (CustomException l) => left(l),
            (List<TicketReasonModel> r) => right(r)));
  }
}
