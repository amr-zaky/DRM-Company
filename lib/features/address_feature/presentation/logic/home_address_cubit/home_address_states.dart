import '/core/error_handling/custom_exception.dart';

abstract class HomeAddressStates {}

class HomeAddressStateInit extends HomeAddressStates {}

class HomeAddressLoadingState extends HomeAddressStates {}

class HomeAddressEmptyState extends HomeAddressStates {}

class HomeAddressSuccessState extends HomeAddressStates {}

class HomeAddressErrorState extends HomeAddressStates {
  HomeAddressErrorState({
    this.error,
  });

  CustomException? error;
}
