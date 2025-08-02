import '/core/error_handling/custom_exception.dart';

abstract class PasswordStates {}

class ForgetPasswordStatesInit extends PasswordStates {}

class ForgetPasswordLoadingState extends PasswordStates {}

class ForgetPasswordForgetSuccessState extends PasswordStates {}

class ForgetPasswordSuccessState extends PasswordStates {}

class ForgetPasswordErrorState extends PasswordStates {
  ForgetPasswordErrorState({this.error});
  CustomException? error;
}

/// Send Verification Code To Email
class SendVerificationStateLoading extends PasswordStates {}

class SendVerificationStateError extends PasswordStates {
  SendVerificationStateError({this.error});
  CustomException? error;
}

class SendVerificationStateSuccess extends PasswordStates {
  SendVerificationStateSuccess(this.code);
  String code;
}

/// Change Password
class ChangePasswordStateLoading extends PasswordStates {}

class ChangePasswordStateError extends PasswordStates {
  ChangePasswordStateError({this.error});
  CustomException? error;
}

class ChangePasswordStateSuccess extends PasswordStates {}

class ToggleHidePassword extends PasswordStates {}

class ChangePasswordValidation extends PasswordStates {}

/// Check Password to Delete Account
class CheckPasswordLoadingState extends PasswordStates {}

class CheckPasswordSuccessState extends PasswordStates {}

class CheckPasswordFailedState extends PasswordStates {
  CheckPasswordFailedState(this.error);
  CustomException error;
}
