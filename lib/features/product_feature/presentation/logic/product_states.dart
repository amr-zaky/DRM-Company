import '/core/error_handling/custom_exception.dart';

abstract class ProductStates {}

class ProductStateInit extends ProductStates {}

class ProductLoadingState extends ProductStates {}

class ProductLoadingMoreDateState extends ProductStates {}

class ProductEmptyState extends ProductStates {}

class ProductSuccessState extends ProductStates {}

class ProductSuccessMoreDateState extends ProductStates {}

class ProductErrorMoreDateState extends ProductStates {
  ProductErrorMoreDateState({
    this.error,
  });
  CustomException? error;
}

class ProductErrorState extends ProductStates {
  ProductErrorState({
    this.error,
  });
  CustomException? error;
}


