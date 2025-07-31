import 'package:base_project_repo/core/model/address_model.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/error_handling/custom_exception.dart';
import '/features/address_feature/domain/ues_cases/address_ues_cases.dart';
import 'add_address_states.dart';

class AddNewAddressCubit extends Cubit<AddNewAddressStates> {
  AddNewAddressCubit(this._repo) : super(AddNewAddressStateInit());

  static AddNewAddressCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final AddressUesCases _repo;
  late TextEditingController addressNameController;

  void initCubit() {
    addressNameController = TextEditingController();
  }

  /// Get All notification List
  void addNewAddress(
      {required num lat,
      required num lng,
      required String fullDescription}) async {
    emit(AddNewAddressLoadingState());
    final Either<CustomException, SuccessModel> result =
        await _repo.addNewAddress(
      lat: lat.toDouble(),
      lng: lng.toDouble(),
      addressName: addressNameController.text,
      isDefault: 1,
      fullAddress: fullDescription,
    );
    result.fold((CustomException error) => emit(AddNewAddressErrorState()),
        (SuccessModel add) {
      emit(AddNewAddressSuccessState());
    });
  }
}
