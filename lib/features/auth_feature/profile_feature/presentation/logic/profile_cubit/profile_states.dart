import '/core/error_handling/custom_exception.dart';

abstract class ProfileCubitStates {}

class ProfileStatesInit extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileLoadingState extends ProfileCubitStates {}

class ProfileSuccessState extends ProfileCubitStates {}

class RemovePhotoSuccessState extends ProfileCubitStates {}

/// show failed for user
class ProfileErrorState extends ProfileCubitStates {
  ProfileErrorState({
    this.error,
  });
  CustomException? error;
}

class UploadingUserImageLoadingState extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileUpdateLoadingState extends ProfileCubitStates {}

class ProfileUpdateSuccessState extends ProfileCubitStates {}

class ProfileUpdateFailedState extends ProfileCubitStates {
  ProfileUpdateFailedState(this.error);
  CustomException error;
}
