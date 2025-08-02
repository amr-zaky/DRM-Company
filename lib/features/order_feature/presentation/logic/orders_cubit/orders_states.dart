import '/core/error_handling/custom_exception.dart';

abstract class OrderStates {}

class OrderStateInit extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class OrderLoadingMoreDateState extends OrderStates {}

class OrderEmptyState extends OrderStates {}

class OrderSuccessState extends OrderStates {}

class OrderSuccessMoreDateState extends OrderStates {}

class OrderErrorMoreDateState extends OrderStates {
  OrderErrorMoreDateState({
    this.error,
  });

  CustomException? error;
}

class OrderErrorState extends OrderStates {
  OrderErrorState({
    this.error,
  });

  CustomException? error;
}

class DeleteOrderLoadingState extends OrderStates {}

class DeleteOrderSuccessState extends OrderStates {}

class DeleteOrderErrorState extends OrderStates {
  DeleteOrderErrorState({
    this.error,
  });

  CustomException? error;
}
