import '/core/error_handling/custom_exception.dart';

abstract class UpdateOrderStates {}

class UpdateOrderStateInit extends UpdateOrderStates {}

class UpdateOrderLoadingState extends UpdateOrderStates {}



class UpdateOrderSuccessState extends UpdateOrderStates {}




class UpdateOrderErrorState extends UpdateOrderStates {
  UpdateOrderErrorState({
    this.error,
  });
  CustomException? error;
}


class SelectServiceState extends UpdateOrderStates {}


