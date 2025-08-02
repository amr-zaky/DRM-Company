import '/core/error_handling/custom_exception.dart';

abstract class PhoneStates {}

class PhoneInitState extends PhoneStates {}

class PhoneLoadingState extends PhoneStates {}

class PhoneSuccessState extends PhoneStates {}

class PhoneFailedState extends PhoneStates {
  PhoneFailedState(this.customError);
  final CustomException customError;
}
