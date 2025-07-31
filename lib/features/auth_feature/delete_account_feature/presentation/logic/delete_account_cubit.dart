import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/delete_account_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/reason_model.dart';
import '/core/model/success_model.dart';
import 'delete_account_states.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountStates> {
  DeleteAccountCubit(this.deleteAccountUseCase)
      : super(DeleteAccountInitState());
  final DeleteAccountUseCase deleteAccountUseCase;

  List<ReasonModel> reasons = <ReasonModel>[];
  ReasonModel? selectedReasonModel;

  bool isOthersSelected = false;
  TextEditingController noteController = TextEditingController();

  void getReasons() async {
    emit(DeleteAccountReasonsLoadingState());
    await deleteAccountUseCase.getReasons().then(
        (Either<CustomException, List<ReasonModel>> value) => value.fold(
                (CustomException failure) =>
                    emit(DeleteAccountFailedState(failure)),
                (List<ReasonModel> success) {
              if (success.isEmpty) {
                emit(DeleteAccountReasonsEmptyState());
              } else {
                reasons = success;
                selectedReasonModel = reasons.first;
                emit(DeleteAccountReasonsSuccessState());
              }
            }));
  }

  void selectReason(ReasonModel model) {
    selectedReasonModel = model;
    if (model.id! == reasons.last.id!) {
      isOthersSelected = true;
    } else {
      isOthersSelected = false;
    }

    emit(SelectDeleteAccountReasonState());
  }

  void disposeControllers() {
    noteController.dispose();
  }

  void deleteAccount(
      {required String reason, required String reasonNote}) async {
    emit(DeleteAccountLoadingState());

    final Either<CustomException, SuccessModel> result =
        await deleteAccountUseCase.deleteAccount(
            reason: reason, reasonNote: reasonNote);

    result.fold(
        (CustomException failure) => emit(DeleteAccountFailedState(failure)),
        (SuccessModel success) => emit(DeleteAccountSuccessState()));
  }
}
