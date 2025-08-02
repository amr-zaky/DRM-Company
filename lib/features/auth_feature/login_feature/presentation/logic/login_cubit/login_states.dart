import '/core/error_handling/custom_exception.dart';

abstract class LoginStates {}

class LoginStatesInit extends LoginStates {}

class LoginValidation extends LoginStates {}

class LoginPasswordToggle extends LoginStates {}

class UserLoginLoadingState extends LoginStates {}

class LoginUnVerifiedState extends LoginStates {
  LoginUnVerifiedState({this.userPhone});
  String? userPhone;
}

class UserLogInSuccessState extends LoginStates {}

class UserLoginErrorState extends LoginStates {
  UserLoginErrorState({this.error});
  CustomException? error;
}

class UserLogoutLoadingState extends LoginStates {}

class UserLogoutSuccessState extends LoginStates {}

class UserLogOutErrorState extends LoginStates {
  UserLogOutErrorState({this.error});
  CustomException? error;
}
