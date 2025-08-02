import '/core/error_handling/custom_exception.dart';

abstract class HomeOrderStates {}

class OrderStateInit extends HomeOrderStates {}

class HomeOrderLoadingState extends HomeOrderStates {}

class HomeOrderEmptyState extends HomeOrderStates {}

class HomeOrderSuccessState extends HomeOrderStates {}

class HomeOrderErrorState extends HomeOrderStates {
  HomeOrderErrorState({
    this.error,
  });

  CustomException? error;
}
