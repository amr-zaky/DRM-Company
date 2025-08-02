import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/phone_use_case.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';
import 'phone_states.dart';

class PhoneCubit extends Cubit<PhoneStates> {
  PhoneCubit(this.phoneUseCase) : super(PhoneInitState());
  final PhoneUseCase phoneUseCase;

  static PhoneCubit get(BuildContext context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();
  TextEditingController newPhoneController = TextEditingController();

  bool isDataValid = false;
  bool isPasswordValid = false;
  bool isShowPassword = false;

  void initialController() {
    phoneController = TextEditingController();
    newPhoneController = TextEditingController();
    emit(PhoneInitState());
  }

  void disposeController() {
    phoneController.dispose();
    newPhoneController.dispose();
    emit(PhoneInitState());
  }

  void checkIsDataValid() {
    isDataValid =
        phoneController.text.isNotEmpty && newPhoneController.text.isNotEmpty;

    emit(PhoneInitState());
  }

  void changePhone({
    required String oldPhone,
    required String newPhone,
    required String password,
  }) async {
    emit(PhoneLoadingState());

    final Either<CustomException, BaseModel> result =
        await phoneUseCase.changePhone(
            entity: AuthEntity(
                phone: oldPhone, newPhone: newPhone, password: password));

    result.fold(
      (CustomException failed) {
        emit(PhoneFailedState(failed));
      },
      (BaseModel success) {
        emit(PhoneSuccessState());
      },
    );
  }
}
