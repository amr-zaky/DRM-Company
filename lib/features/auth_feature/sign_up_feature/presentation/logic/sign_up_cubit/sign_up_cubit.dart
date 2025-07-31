import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/use_cases/sign_up_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/success_model.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this.useCase) : super(SignUpStatesInit());
  final SignUpUseCase useCase;

  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  List<TextEditingController> controllerList = <TextEditingController>[];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
  late TextEditingController emailAddressController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late bool isDataFound;

  void setupController() {
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailAddressController = TextEditingController();
    isDataFound = false;
    hidePassword = true;
    hideConfirmPassword = true;
    controllerList.clear();
    controllerList.add(userNameController);
    controllerList.add(phoneNumberController);
    controllerList.add(passwordController);
    controllerList.add(confirmPasswordController);
    controllerList.add(emailAddressController);
    emit(SignUpStatesInit());
  }

  void disposeController() {
    userNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailAddressController.dispose();
    emit(SignUpStatesInit());
  }

  void switchPasswordToggle({bool? isMainPassword = true}) {
    if (isMainPassword!) {
      hidePassword = !hidePassword;
    } else {
      hideConfirmPassword = !hideConfirmPassword;
    }
    emit(ShowOrHidePasswordState());
  }

  void singUp(
      {required String username,
      required String phone,
      required String password,
      required String confirmPassword,
      required String email,
      required String token}) async {
    emit(UserSignUpLoadingState());

    final Either<CustomException, SuccessModel> result =
        await useCase.singUpUser(
            entity: AuthEntity(
                name: username,
                idCardNumber: "",
                phone: phone,
                password: password,
                email: email,
                confirmPassword: confirmPassword,
                deviceToken: token));

    result.fold(
        (CustomException failure) => emit(UserSignUpErrorState(error: failure)),
        (SuccessModel success) => emit(UserSignUpSuccessState()));
  }

  void isDataFount() {
    isDataFound = true;
    emit(CheckInputValidationState());

    for (final TextEditingController element in controllerList) {
      if (element.text.isEmpty) {
        isDataFound = false;
        return;
      }
    }
    emit(CheckInputValidationState());
  }
}
