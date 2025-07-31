import 'package:base_project_repo/core/error_handling/custom_exception.dart';

abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

class OrderUpdateSelectionState extends OrderStates {}

class CreateOrderLoadingState extends OrderStates {}

class CreateOrderSuccessState extends OrderStates {}

class CreateOrderFailState extends OrderStates {
  CreateOrderFailState(this.error);

  CustomException error;
}
