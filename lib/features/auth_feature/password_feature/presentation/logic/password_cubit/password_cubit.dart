import 'package:base_project_repo/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/password_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import 'password_states.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  PasswordCubit(this._forgetUserCase) : super(ForgetPasswordStatesInit());

  static PasswordCubit get(BuildContext context) => BlocProvider.of(context);

  final PasswordUseCases _forgetUserCase;
  bool hideOldPassword = true;
  bool passwordValidation = false;

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  void initialController() {
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    hideOldPassword = true;
    hidePassword = true;
    hideConfirmPassword = true;
    passwordValidation = false;
    emit(ForgetPasswordStatesInit());
  }

  void disposeController() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emit(ForgetPasswordStatesInit());
  }

  void resetState() {
    emit(ForgetPasswordStatesInit());
  }

  void toggleHideOldPassword() {
    hideOldPassword = !hideOldPassword;
    emit(ToggleHidePassword());
  }

  void toggleHidePassword() {
    hidePassword = !hidePassword;
    emit(ToggleHidePassword());
  }

  void toggleConfirmPassword() {
    hideConfirmPassword = !hideConfirmPassword;
    emit(ToggleHidePassword());
  }

  void checkPasswordFieldValid(String fieldValue) {
    passwordValidation = fieldValue.isNotEmpty;
    emit(ChangePasswordValidation());
  }

  /// Change New Password
  void changeNewPassword(
      {required String userCredential,
      required String otp,
      required String password,
      required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    final Either<CustomException, BaseModel> result =
        await _forgetUserCase.resetPassword(
            passwordAuthEntity: AuthEntity(
                userCredential: userCredential,
                newPassword: password,
                confirmPassword: confirmPassword,
                otp: otp));

    result.fold(
        (CustomException failure) =>
            emit(ChangePasswordStateError(error: failure)),
        (BaseModel success) => emit(ChangePasswordStateSuccess()));
  }

  /// Change  Password
  void changePassword(
      {required String oldPassword,
      required String password,
      required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    final Either<CustomException, BaseModel> result =
        await _forgetUserCase.changePassword(
            passwordAuthEntity: AuthEntity(
                password: oldPassword,
                newPassword: password,
                confirmPassword: confirmPassword));

    result.fold(
        (CustomException failure) =>
            emit(ChangePasswordStateError(error: failure)),
        (BaseModel success) => emit(ChangePasswordStateSuccess()));
  }

  void checkPassword() async {
    emit(CheckPasswordLoadingState());
    final Either<CustomException, BaseModel> result =
        await _forgetUserCase.checkPassword(password: passwordController.text);

    result.fold(
        (CustomException failure) => emit(CheckPasswordFailedState(failure)),
        (BaseModel success) => emit(CheckPasswordSuccessState()));
  }
}
