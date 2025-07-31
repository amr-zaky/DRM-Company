import '/core/error_handling/custom_exception.dart';

abstract class AddressStates {}

class AddressStateInit extends AddressStates {}

class AddressLoadingState extends AddressStates {}

class AddressLoadingMoreDateState extends AddressStates {}

class AddressEmptyState extends AddressStates {}

class AddressSuccessState extends AddressStates {}

class AddressSuccessMoreDateState extends AddressStates {}

class AddressErrorMoreDateState extends AddressStates {
  AddressErrorMoreDateState({
    this.error,
  });
  CustomException? error;
}

class AddressErrorState extends AddressStates {
  AddressErrorState({
    this.error,
  });
  CustomException? error;
}


