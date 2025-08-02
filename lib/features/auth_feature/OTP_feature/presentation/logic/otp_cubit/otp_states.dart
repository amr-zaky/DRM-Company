import '/core/error_handling/custom_exception.dart';

abstract class OtpStates {}

class OtpStatesInit extends OtpStates {}

class OtpLoadingState extends OtpStates {}

class OtpSuccessState extends OtpStates {}

class OtpErrorState extends OtpStates {
  OtpErrorState({
    this.error,
  });
  CustomException? error;
}

class ResendOtpLoadingState extends OtpStates {}

class ResendOtpSuccessState extends OtpStates {
  ResendOtpSuccessState(this.otp);
  String otp;
}

class SendOtpLoadingState extends OtpStates {}

class SendOtpSuccessState extends OtpStates {
  SendOtpSuccessState(this.otp);
  String otp;
}
