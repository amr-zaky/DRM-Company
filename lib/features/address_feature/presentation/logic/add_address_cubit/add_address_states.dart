import '/core/error_handling/custom_exception.dart';

abstract class AddNewAddressStates {}

class AddNewAddressStateInit extends AddNewAddressStates {}

class AddNewAddressLoadingState extends AddNewAddressStates {}

class AddNewAddressSuccessState extends AddNewAddressStates {}

class AddNewAddressErrorState extends AddNewAddressStates {
  AddNewAddressErrorState({
    this.error,
  });

  CustomException? error;
}
