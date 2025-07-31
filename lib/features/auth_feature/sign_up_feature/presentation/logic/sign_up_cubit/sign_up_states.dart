import '/core/error_handling/custom_exception.dart';

abstract class SignUpStates {}

class SignUpStatesInit extends SignUpStates {}

/// Show loader for user login
class UserSignUpLoadingState extends SignUpStates {}

/// Go to home after success
class UserSignUpSuccessState extends SignUpStates {}

/// Show failed login for user
class UserSignUpErrorState extends SignUpStates {
  UserSignUpErrorState({
    this.error,
  });
  CustomException? error;
}

class UploadingUserImageLoadingState extends SignUpStates {}

class ShowOrHidePasswordState extends SignUpStates {}

class CheckInputValidationState extends SignUpStates {}
