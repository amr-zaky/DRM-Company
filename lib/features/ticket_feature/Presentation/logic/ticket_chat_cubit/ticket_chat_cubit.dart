import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/model/ticket_comment_model.dart';
import '../../../Domain/ues_cases/ticket_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import 'ticket_chat_states.dart';

class TicketChatCubit extends Cubit<TicketChatStates> {
  TicketChatCubit(this.useCase) : super(TicketChatInitState());
  final TicketUseCase useCase;

  static TicketChatCubit get(BuildContext context) =>
      BlocProvider.of<TicketChatCubit>(context);

  TextEditingController messageController = TextEditingController();

  late String ticketId;
  List<TicketComment> comments = <TicketComment>[];
  List<TicketComment> commentsTemp = <TicketComment>[];

  ///tickets pagination
  int chatPage = 1;
  late ScrollController ticketScrollController;
  bool ticketHasMoreData = false;

  void setupTicketScrollController(String id) {
    ticketId = id;
    if (ticketScrollController.offset >
            ticketScrollController.position.maxScrollExtent - 200 &&
        ticketScrollController.offset <=
            ticketScrollController.position.maxScrollExtent) {
      if (state is! TicketChatGetMoreDataState && ticketHasMoreData) {
        whenScrollQuestionPagination();
      }
    }
  }

  ///Question Pagination Function
  void whenScrollQuestionPagination() async {
    emit(TicketChatGetMoreDataState());

    chatPage = chatPage + 1;
    final Either<CustomException, List<TicketComment>> result =
        await useCase.getTicketComments(ticketId: ticketId);
    result.fold(
        (CustomException error) => emit(TicketChatGetDataFailState(error)),
        (List<TicketComment> success) {
      comments.addAll(success);
      emit(TicketChatGetDataSuccessState());
    });
  }

  void getTicketComments({
    required String ticketId,
  }) async {
    emit(TicketChatGetDataLoadingState());
    this.ticketId = ticketId;
    comments.clear();
    messageController.text = '';
    final Either<CustomException, List<TicketComment>> result =
        await useCase.getTicketComments(ticketId: ticketId);
    result.fold(
        (CustomException error) => emit(TicketChatGetDataFailState(error)),
        (List<TicketComment> success) {
      comments = success;
      emit(TicketChatSendMessageSuccessState());
    });
  }

  void sendMessage({required String ticketId, required String message}) async {
    emit(TicketChatSendMessageLoadingState());
    final Either<CustomException, TicketComment> result =
        await useCase.sendComment(ticketId: ticketId, comment: message);
    result.fold(
        (CustomException error) => emit(TicketChatSendMessageFailState(error)),
        (TicketComment success) {
      comments.add(success);
      emit(TicketChatSendMessageSuccessState());
    });
  }
}
