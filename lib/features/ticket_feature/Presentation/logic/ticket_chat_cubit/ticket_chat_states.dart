import '/core/error_handling/custom_exception.dart';

abstract class TicketChatStates {}

class TicketChatInitState extends TicketChatStates {}

class TicketChatGetDataLoadingState extends TicketChatStates {}

class TicketChatGetMoreDataState extends TicketChatStates {}

class TicketChatGetDataSuccessState extends TicketChatStates {}

class TicketChatGetDataEmptyState extends TicketChatStates {}

class TicketChatGetDataFailState extends TicketChatStates {
  TicketChatGetDataFailState(this.error);
  final CustomException error;
}

class TicketChatSendMessageLoadingState extends TicketChatStates {}

class TicketChatSendMessageSuccessState extends TicketChatStates {}

class TicketChatSendMessageFailState extends TicketChatStates {
  TicketChatSendMessageFailState(this.error);
  final CustomException error;
}
