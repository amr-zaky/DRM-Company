import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/splash_use_case.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/success_model.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit(this._userUseCases) : super(SplashStatesInit());

  final SplashUseCase _userUseCases;

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void getCachedUser() async {
    final Either<CustomException, SuccessModel> result =
        await _userUseCases.checkExistingUser();

    result.fold((CustomException failure) {
      emit(UserNotFoundState(
          failure.type == CustomStatusCodeErrorType.unVerified));
    }, (SuccessModel success) => emit(UserFoundState()));
  }
}
