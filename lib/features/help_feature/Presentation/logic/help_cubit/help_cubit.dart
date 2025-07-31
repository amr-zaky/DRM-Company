import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/model/faq_model.dart';
import '../../../Domain/ues_cases/help_ues_cases.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/success_model.dart';
import 'help_states.dart';

class HelpCubit extends Cubit<HelpStates> {
  HelpCubit(this.useCase) : super(HelpInitState());
  final HelpUesCases useCase;

  static HelpCubit get(BuildContext context) => BlocProvider.of(context);

  List<FAQModel> questionList = <FAQModel>[];
  List<FAQModel> questionTempList = <FAQModel>[];

  ///Question pagination
  int questionPage = 1;
  late ScrollController questionScrollController;
  bool questionHasMoreData = false;

  void setupQuestionScrollController() {
    if (questionScrollController.offset >
            questionScrollController.position.maxScrollExtent - 200 &&
        questionScrollController.offset <=
            questionScrollController.position.maxScrollExtent) {
      if (state is! HelpGetMoreQuestionLoadingState && questionHasMoreData) {
        whenScrollQuestionPagination();
      }
    }
  }

  ///Question Pagination Function
  void whenScrollQuestionPagination() async {
    emit(HelpGetMoreQuestionLoadingState());

    questionPage = questionPage + 1;
    final Either<CustomException, List<FAQModel>> result =
        await useCase.getQuestionList(page: questionPage);
    result.fold(
        (CustomException error) => emit(HelpGetMoreQuestionFailState(error)),
        (List<FAQModel> list) {
      questionHasMoreData = list.length == 10;
      questionList.addAll(list);
      questionTempList.addAll(list);
      emit(HelpGetMoreQuestionSuccessState());
    });
  }

  ///get question list
  void getQuestions() async {
    emit(HelpGetQuestionLoadingState());
    questionPage = 1;
    final Either<CustomException, List<FAQModel>> result =
        await useCase.getQuestionList(page: questionPage);
    result
        .fold((CustomException error) => emit(HelpGetQuestionFailState(error)),
            (List<FAQModel> list) {
      if (list.isEmpty) {
        emit(HelpGetQuestionEmptyState());
      } else {
        questionHasMoreData = list.length == 10;
        questionList = list;
        questionTempList = list;
        emit(HelpGetQuestionSuccessState());
      }
    });
    emit(HelpGetQuestionSuccessState());
  }

  void addContact({
    required String subject,
    required String message,
  }) async {
    emit(HelpAddContactLoadingState());
    final Either<CustomException, SuccessModel> result =
        await useCase.addContact(
      name: SharedText.currentUser!.name!,
      email: SharedText.currentUser!.email ?? "",
      phone: SharedText.currentUser!.phone!,
      subject: subject,
      message: message,
    );
    result.fold((CustomException error) => emit(HelpAddContactFailState(error)),
        (SuccessModel success) => emit(HelpAddContactSuccessState()));
  }

  void search(String str) {
    questionList = questionTempList.where((FAQModel element) {
      return element.question.toLowerCase().contains(str.toLowerCase());
    }).toList();
    emit(HelpSearchChangeState());
  }
}
