import '/core/error_handling/custom_exception.dart';

abstract class HelpStates {}

class HelpInitState extends HelpStates {}

class HelpGetQuestionLoadingState extends HelpStates {}

class HelpGetMoreQuestionLoadingState extends HelpStates {}

class HelpGetQuestionSuccessState extends HelpStates {}

class HelpGetMoreQuestionSuccessState extends HelpStates {}

class HelpGetQuestionFailState extends HelpStates {
  HelpGetQuestionFailState(this.error);
  final CustomException error;
}

class HelpGetMoreQuestionFailState extends HelpStates {
  HelpGetMoreQuestionFailState(this.error);
  final CustomException error;
}

class HelpGetQuestionEmptyState extends HelpStates {}

class HelpSearchChangeState extends HelpStates {}

class HelpAddContactLoadingState extends HelpStates {}

class HelpAddContactSuccessState extends HelpStates {}

class HelpAddContactFailState extends HelpStates {
  HelpAddContactFailState(this.error);
  final CustomException error;
}
