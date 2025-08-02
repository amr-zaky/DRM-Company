import '../../../Domain/model/ticket_model.dart';
import '/core/error_handling/custom_exception.dart';

abstract class TicketStates {}

class TicketInitState extends TicketStates {}

class TicketGetDataLoadingState extends TicketStates {}

class TicketGetMoreDataState extends TicketStates {}

class TicketGetDataSuccessState extends TicketStates {}

class TicketGetDataEmptyState extends TicketStates {}

class TicketGetDataFailState extends TicketStates {
  TicketGetDataFailState(this.error);
  final CustomException error;
}

class TicketSentLoadingState extends TicketStates {}

class TicketSentSuccessState extends TicketStates {
  TicketSentSuccessState(this.ticketModel);
  final TicketModel ticketModel;
}

class TicketSentFailState extends TicketStates {
  TicketSentFailState(this.error);
  final CustomException error;
}

class TicketGetTicketReasonLoadingState extends TicketStates {}

class TicketGetTicketReasonSuccessState extends TicketStates {}

class TicketGetTicketReasonEmptyState extends TicketStates {}

class TicketSelectReasonState extends TicketStates {}

class TicketGetTicketReasonFailState extends TicketStates {
  TicketGetTicketReasonFailState(this.error);
  final CustomException error;
}
