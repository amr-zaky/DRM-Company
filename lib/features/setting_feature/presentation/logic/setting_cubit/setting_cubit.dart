import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/setting_model.dart';
import '../../../domain/ues_cases/setting_ues_cases.dart';
import '/core/error_handling/custom_exception.dart';
import 'setting_cubit_states.dart';

class SettingCubit extends Cubit<SettingCubitState> {
  SettingCubit(this._userUseCases) : super(SettingInitialState());

  static SettingCubit get(BuildContext context) =>
      BlocProvider.of<SettingCubit>(
        context,
      );

  final SettingUserCase _userUseCases;
  late SettingModel settingModel;

  String pageContent = "";

  void getSetting() async {
    emit(SettingLoadingState());
    final Either<CustomException, SettingModel> result =
        await _userUseCases.callAppSetting();
    result.fold((CustomException error) => emit(SettingFailedState(error)),
        (SettingModel setting) {
      settingModel = setting;
      emit(SettingSuccessState());
    });
  }

  void getSettingPageContent(String apiKey) async {
    emit(SettingLoadingState());
    final Either<CustomException, String> result =
        await _userUseCases.callAppSettingByPage(apiKey);
    result.fold((CustomException error) => emit(SettingFailedState(error)),
        (String setting) {
      pageContent = setting;
      emit(SettingSuccessState());
    });
  }
}
