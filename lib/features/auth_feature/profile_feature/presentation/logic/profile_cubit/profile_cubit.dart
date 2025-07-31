import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/use_cases/profile_ues_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/shared_texts.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit(this._uesCase) : super(ProfileStatesInit());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  final ProfileUseCases _uesCase;

  XFile? imageXFile;
  bool imgChange = false;
  late TextEditingController userNameController;
  late TextEditingController emailController;

  void initialController() {
    userNameController =
        TextEditingController(text: SharedText.currentUser?.name);
    emailController =
        TextEditingController(text: SharedText.currentUser?.email);
    imageXFile = null;
    emit(ProfileStatesInit());
  }

  void disposeController() {
    userNameController.dispose();
    emailController.dispose();
    emit(ProfileStatesInit());
  }

  /// user Profile_Cubit data
  void getUserProfileData() async {
    emit(ProfileUpdateLoadingState());
    final Either<CustomException, BaseModel> result =
        await _uesCase.getUserProfile();
    result.fold(
        (CustomException failure) => emit(ProfileUpdateFailedState(failure)),
        (BaseModel success) => emit(ProfileUpdateSuccessState()));
  }

  void removeProfilePhoto() async {
    emit(ProfileUpdateLoadingState());
    final Either<CustomException, BaseModel> result =
        await _uesCase.removePhoto();
    result.fold(
        (CustomException failure) => emit(ProfileUpdateFailedState(failure)),
        (BaseModel success) => emit(RemovePhotoSuccessState()));
  }

  ///update user profile
  void updateUserProfile({
    required String name,
    required String? email,
    XFile? image,
  }) async {
    emit(ProfileUpdateLoadingState());
    final Either<CustomException, BaseModel> result =
        await _uesCase.updateUserProfile(
            entity: AuthEntity(name: name, email: email, imageXFile: image));
    result.fold(
        (CustomException failure) => emit(ProfileUpdateFailedState(failure)),
        (BaseModel success) => emit(ProfileUpdateSuccessState()));
  }

  void photoPicked(XFile xFile) {
    imageXFile = xFile;
    emit(UploadingUserImageLoadingState());
  }

  void deleteImageFunc() {
    imageXFile = null;
    emit(UploadingUserImageLoadingState());
  }
}
