import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/custom_exception.dart';
import '../../../../core/helpers/connectivity/connection_checker.dart';
import '../../Domain/model/ticket_comment_model.dart';
import '../../Domain/model/ticket_model.dart';
import '../../Domain/model/ticket_reason_model.dart';
import '../../Domain/reposiroty/ticket_interface.dart';
import '../data_source/remote_ticket_date_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/model/base_model.dart';

class TicketRepository extends TicketInterface {
  TicketRepository(
      {required this.ticketRemoteDataSource,
      required this.connectionCheckerInterface});

  final TicketRemoteDataScoursInterface ticketRemoteDataSource;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, TicketModel>> openTicket(
      {required int reasonId,
      required String note,
      required String subject}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return ticketRemoteDataSource
              .openTicket(
                reasonId: reasonId,
                subject: subject,
                note: note,
              )
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(TicketModel.fromJson(r.data))));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, List<TicketModel>>> getTicketsList(
      {required int page, int? limit}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return ticketRemoteDataSource
              .getTicketsList(page: page, limit: limit)
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(ticketListFromJson(r.data))));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, List<TicketComment>>> getTicketComments(
      {required String ticketId}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return ticketRemoteDataSource
              .getTicketComments(ticketId: ticketId)
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(ticketCommentListFromJson(r.data))));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, TicketComment>> sendComment(
      {required String ticketId, required String comment}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return ticketRemoteDataSource
              .sendComment(ticketId: ticketId, comment: comment)
              .then((Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(TicketComment.fromJson(r.data))));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, List<TicketReasonModel>>>
      getTicketCategory() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return ticketRemoteDataSource.getTicketCategory().then(
              (Either<CustomException, BaseModel> value) => value.fold(
                  (CustomException l) => left(l),
                  (BaseModel r) => right(ticketReasonListFromJson(r.data))));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
