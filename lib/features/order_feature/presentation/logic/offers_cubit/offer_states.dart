import '/core/error_handling/custom_exception.dart';

abstract class OfferStates {}

class OfferStateInit extends OfferStates {}

class OfferLoadingState extends OfferStates {}

class OfferLoadingMoreDateState extends OfferStates {}

class OfferEmptyState extends OfferStates {}

class OfferSuccessState extends OfferStates {}

class OfferSuccessMoreDateState extends OfferStates {}

class OfferErrorMoreDateState extends OfferStates {
  OfferErrorMoreDateState({
    this.error,
  });

  CustomException? error;
}

class OfferErrorState extends OfferStates {
  OfferErrorState({
    this.error,
  });

  CustomException? error;
}

class DeleteOfferLoadingState extends OfferStates {}

class DeleteOfferSuccessState extends OfferStates {}

class DeleteOfferErrorState extends OfferStates {
  DeleteOfferErrorState({
    this.error,
  });

  CustomException? error;
}
