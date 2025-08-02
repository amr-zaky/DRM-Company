import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/model/ticket_model.dart';
import '../../../Domain/model/ticket_reason_model.dart';
import '../../../Domain/ues_cases/ticket_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import 'ticket_states.dart';

class TicketCubit extends Cubit<TicketStates> {
  TicketCubit(this.useCase) : super(TicketInitState());
  final TicketUseCase useCase;

  static TicketCubit get(BuildContext context) =>
      BlocProvider.of<TicketCubit>(context);

  List<TicketModel> ticketList = <TicketModel>[];
  List<TicketReasonModel> ticketReasonList = <TicketReasonModel>[];

  TicketReasonModel? selectedReason;

  bool isOthersSelected = false;

  ///tickets pagination
  int ticketPage = 1;
  late ScrollController ticketScrollController;
  bool ticketHasMoreData = false;

  void setupTicketScrollController() {
    if (ticketScrollController.offset >
            ticketScrollController.position.maxScrollExtent - 200 &&
        ticketScrollController.offset <=
            ticketScrollController.position.maxScrollExtent) {
      if (state is! TicketGetMoreDataState && ticketHasMoreData) {
        whenScrollQuestionPagination();
      }
    }
  }

  ///Question Pagination Function
  void whenScrollQuestionPagination() async {
    emit(TicketGetMoreDataState());

    ticketPage = ticketPage + 1;
    final Either<CustomException, List<TicketModel>> result =
        await useCase.getTicketsList(page: ticketPage);
    result.fold((CustomException error) => emit(TicketGetDataFailState(error)),
        (List<TicketModel> list) {
      ticketHasMoreData = list.length == 10;
      ticketList.addAll(list);
      emit(TicketGetDataSuccessState());
    });
  }

  void selectReason(TicketReasonModel model) {
    selectedReason = model;
    if (model.id == ticketReasonList.last.id) {
      isOthersSelected = true;
    } else {
      isOthersSelected = false;
    }
    emit(TicketSelectReasonState());
  }

  void getTickets() async {
    emit(TicketGetDataLoadingState());
    ticketList.clear();
    ticketPage = 1;
    final Either<CustomException, List<TicketModel>> result =
        await useCase.getTicketsList(page: ticketPage);
    result.fold((CustomException error) => emit(TicketGetDataFailState(error)),
        (List<TicketModel> list) {
      if (list.isEmpty) {
        emit(TicketGetDataEmptyState());
      } else {
        ticketHasMoreData = list.length == 10;
        ticketList.addAll(list);
        emit(TicketGetDataSuccessState());
      }
    });
  }

  void getTicketReasons() async {
    ticketReasonList.clear();
    selectedReason = null;
    emit(TicketGetTicketReasonLoadingState());
    final Either<CustomException, List<TicketReasonModel>> result =
        await useCase.getTicketCategory();
    result.fold(
        (CustomException error) => emit(TicketGetTicketReasonFailState(error)),
        (List<TicketReasonModel> list) {
      if (list.isEmpty) {
        emit(TicketGetTicketReasonEmptyState());
      } else {
        ticketReasonList.addAll(list);
        emit(TicketGetTicketReasonSuccessState());
      }
    });
  }

  void openProblemTicket(
      {required int reasonId,
      required String note,
      required String subject}) async {
    emit(TicketSentLoadingState());
    final Either<CustomException, TicketModel> result =
        await useCase.openTicket(
      reasonId: reasonId,
      subject: subject,
      note: note,
    );
    result.fold(
        (CustomException error) => emit(TicketSentFailState(error)),
        (TicketModel success) =>
            emit(TicketSentSuccessState(success..isOpen = true)));
  }
}
