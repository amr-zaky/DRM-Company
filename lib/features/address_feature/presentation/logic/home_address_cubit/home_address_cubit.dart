import 'package:base_project_repo/core/model/address_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/error_handling/custom_exception.dart';
import '/features/address_feature/domain/ues_cases/address_ues_cases.dart';
import 'home_address_states.dart';

class HomeAddressCubit extends Cubit<HomeAddressStates> {
  HomeAddressCubit(this._repo) : super(HomeAddressStateInit());

  static HomeAddressCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final AddressUesCases _repo;

  AddressModel? selectedAddressModel;

  ///pagination
  int page = 1;
  List<AddressModel> addressList = <AddressModel>[];

  Future<dynamic> onRefresh() async {
    getAddressList();
  }

  void setSelectedAddress(AddressModel newSelect) {
    selectedAddressModel = newSelect;
  }

  /// Get All notification List
  void getAddressList() async {
    emit(HomeAddressLoadingState());
    page = 1;
    final Either<CustomException, List<AddressModel>> result =
        await _repo.getAddressList(page: page, limit: 50);
    result.fold((CustomException error) => emit(HomeAddressErrorState()),
        (List<AddressModel> addressListData) {
      addressList = addressListData;
      if (addressList.isEmpty) {
        emit(HomeAddressEmptyState());
      } else {
        selectedAddressModel =
            addressListData.firstWhere((AddressModel element) {
          return element.isDefault!;
        });
        emit(HomeAddressSuccessState());
      }
    });
  }
}
