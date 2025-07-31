import '/core/error_handling/custom_exception.dart';

abstract class SettingCubitState {}

class SettingInitialState extends SettingCubitState {}

class SettingLoadingState extends SettingCubitState {}

class SettingSuccessState extends SettingCubitState {}

class SettingFailedState extends SettingCubitState {
  SettingFailedState(this.error);
  CustomException error;
}
