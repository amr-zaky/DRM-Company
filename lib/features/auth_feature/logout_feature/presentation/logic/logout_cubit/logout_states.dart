import '/core/error_handling/custom_exception.dart';

abstract class LogoutStates {}

class LogoutStatesInit extends LogoutStates {}

class UserLogoutLoadingState extends LogoutStates {}

class UserLogoutSuccessState extends LogoutStates {}

class UserLogOutErrorState extends LogoutStates {
  UserLogOutErrorState({this.error});
  CustomException? error;
}
