import 'package:base_project_repo/core/model/success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/logout_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import 'logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit(this._userUseCases) : super(LogoutStatesInit());

  static LogoutCubit get(BuildContext context) => BlocProvider.of(context);

  final LogoutUseCase _userUseCases;

  void logOut() async {
    emit(UserLogoutLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _userUseCases.logOutUser();
    result.fold(
        (CustomException failure) => emit(UserLogOutErrorState(error: failure)),
        (SuccessModel success) => emit(UserLogoutSuccessState()));
  }
}
