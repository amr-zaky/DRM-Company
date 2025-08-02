import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/use_case.dart';
import 'on_boarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit(this._userUseCases) : super(OnBoardingInitState());

  final OnBoardingUseCase _userUseCases;

  static OnBoardingCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;

  void onChangedFunction(int index) {
    currentIndex = index;
    emit(OnBoardingChangePageState());
  }

  void changeUserFirstTime() async {
    await _userUseCases.setUserFirstTime();
    emit(OnBoardingChangeUserFirstTimeState());
  }
}
