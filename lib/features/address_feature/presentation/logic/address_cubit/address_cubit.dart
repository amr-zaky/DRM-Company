import 'package:base_project_repo/core/model/address_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/error_handling/custom_exception.dart';
import '/features/address_feature/domain/ues_cases/address_ues_cases.dart';
import 'address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit(this._repo) : super(AddressStateInit());

  static AddressCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final AddressUesCases _repo;

  bool isNotified = false;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<AddressModel> addressList = <AddressModel>[];
  bool hasMoreData = false;

  Future<dynamic> onRefresh() async {
    getAddressList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! AddressLoadingMoreDateState && hasMoreData) {
        whenScrollAddressPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollAddressPagination() async {
    emit(AddressLoadingMoreDateState());

    page = page + 1;
    final Either<CustomException, List<AddressModel>> result =
        await _repo.getAddressList(page: page);
    result.fold(
        (CustomException error) =>
            emit(AddressErrorMoreDateState(error: error)),
        (List<AddressModel> addressListData) {
      final List<AddressModel> tempList = addressList;
      hasMoreData = tempList.length == 10;
      addressList.addAll(tempList);
      emit(AddressSuccessMoreDateState());
    });
  }

  /// Get All notification List
  void getAddressList() async {
    emit(AddressLoadingState());
    page = 1;
    final Either<CustomException, List<AddressModel>> result =
        await _repo.getAddressList(page: page);
    result.fold((CustomException error) => emit(AddressErrorState()),
        (List<AddressModel> addressListData) {
      addressList = addressListData;
      hasMoreData = addressList.length == 10;
      if (addressList.isEmpty) {
        emit(AddressEmptyState());
      } else {
        emit(AddressSuccessState());
      }
    });
  }
}
