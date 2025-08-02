import 'package:dartz/dartz.dart';

import '../model/ticket_comment_model.dart';
import '../model/ticket_model.dart';
import '../model/ticket_reason_model.dart';
import '/core/error_handling/custom_exception.dart';

abstract class TicketInterface {
  Future<Either<CustomException, List<TicketModel>>> getTicketsList(
      {required int page, int? limit});

  Future<Either<CustomException, TicketModel>> openTicket({
    required int reasonId,
    required String note,
    required String subject,
  });

  Future<Either<CustomException, List<TicketComment>>> getTicketComments(
      {required String ticketId});

  Future<Either<CustomException, List<TicketReasonModel>>> getTicketCategory();

  Future<Either<CustomException, TicketComment>> sendComment({
    required String ticketId,
    required String comment,
  });
}
