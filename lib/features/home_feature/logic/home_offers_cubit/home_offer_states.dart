import '/core/error_handling/custom_exception.dart';

abstract class HomeOfferStates {}

class OfferStateInit extends HomeOfferStates {}

class HomeOfferLoadingState extends HomeOfferStates {}

class HomeOfferEmptyState extends HomeOfferStates {}

class HomeOfferSuccessState extends HomeOfferStates {}

class HomeOfferErrorState extends HomeOfferStates {
  HomeOfferErrorState({
    this.error,
  });

  CustomException? error;
}
