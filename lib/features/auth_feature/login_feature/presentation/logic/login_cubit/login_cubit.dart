import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/login_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._userUseCases) : super(LoginStatesInit());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  final LoginUseCase _userUseCases;

  bool loginValidation = false;
  bool passwordToggle = false;

  void initialController() {
    passwordToggle = true;
    loginValidation = false;
    emit(LoginStatesInit());
  }

  void checkLoginFieldValid(String fieldValue) {
    loginValidation = fieldValue.isNotEmpty;
    emit(LoginValidation());
  }

  void togglePassword() {
    passwordToggle = !passwordToggle;
    emit(LoginPasswordToggle());
  }

  void login(
      {required String userName,
      required String password,
      required String token}) async {
    emit(UserLoginLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _userUseCases.loginUser(
            entity: AuthEntity(
                userCredential: userName,
                password: password,
                deviceToken: token));

    result.fold(
        (CustomException failure) => emit(UserLoginErrorState(error: failure)),
        (SuccessModel success) => emit(UserLogInSuccessState()));
  }
}
