import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/otp_ues_cases.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit(this._otpUesCases) : super(OtpStatesInit());

  static OtpCubit get(BuildContext context) => BlocProvider.of(context);

  final OtpUseCases _otpUesCases;

  void resetState() {
    emit(OtpStatesInit());
  }

  /// Verify Forget Password
  void verifyAccount(
      {required String userCredential, required String otp}) async {
    emit(OtpLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _otpUesCases.verifyAccount(
            entity: AuthEntity(userCredential: userCredential, otp: otp));
    result.fold((CustomException failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (SuccessModel r) => emit(OtpSuccessState()));
  }

  ///check otp
  void checkOtp({required String userCredential, required String otp}) async {
    emit(OtpLoadingState());
    final Either<CustomException, SuccessModel> result = await _otpUesCases
        .checkOtp(entity: AuthEntity(userCredential: userCredential, otp: otp));
    result.fold((CustomException failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (SuccessModel r) => emit(OtpSuccessState()));
  }

  /// Send Verification Code To Email
  void sendVerificationCode({required String userCredential}) async {
    emit(SendOtpLoadingState());
    final Either<CustomException, String> result =
        await _otpUesCases.sendVerificationCode(
      userCredential: userCredential,
    );
    result.fold(
        (CustomException failure) => emit(OtpErrorState(error: failure)),
        (String otpCode) => emit(SendOtpSuccessState(otpCode)));
  }

  ///re send
  void resendOTP({required String userCredential}) async {
    emit(ResendOtpLoadingState());
    final Either<CustomException, String> result =
        await _otpUesCases.resendOTP(userCredential: userCredential);
    result.fold((CustomException failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (String otp) => emit(ResendOtpSuccessState(otp)));
  }
}
