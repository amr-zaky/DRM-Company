import '/core/error_handling/custom_exception.dart';

abstract class DeleteAccountStates {}

class DeleteAccountInitState extends DeleteAccountStates {}

class DeleteAccountLoadingState extends DeleteAccountStates {}

class DeleteAccountSuccessState extends DeleteAccountStates {}

class DeleteAccountFailedState extends DeleteAccountStates {
  DeleteAccountFailedState(this.customError);
  final CustomException customError;
}

class DeleteAccountReasonsLoadingState extends DeleteAccountStates {}

class DeleteAccountReasonsEmptyState extends DeleteAccountStates {}

class DeleteAccountReasonsSuccessState extends DeleteAccountStates {}

class SelectDeleteAccountReasonState extends DeleteAccountStates {}
