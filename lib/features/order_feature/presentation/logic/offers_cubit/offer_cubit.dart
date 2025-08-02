import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error_handling/custom_exception.dart';
import '/features/order_feature/domain/order_model.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import 'offer_states.dart';

class OfferCubit extends Cubit<OfferStates> {
  OfferCubit(this._repo) : super(OfferStateInit());

  static OfferCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final OrdersUesCases _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<OrderModel> offerList = <OrderModel>[];
  bool hasMoreData = false;

  Future<dynamic> onRefresh() async {
    getOfferList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! OfferLoadingMoreDateState && hasMoreData) {
        whenScrollOfferPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollOfferPagination() async {
    emit(OfferLoadingMoreDateState());

    page = page + 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOffers(
      page: page,
      limit: 10,
    );
    result.fold(
        (CustomException error) => emit(OfferErrorMoreDateState(error: error)),
        (List<OrderModel> offerListData) {
      final List<OrderModel> tempList = offerListData;
      hasMoreData = tempList.length == 10;
      offerList.addAll(tempList);
      emit(OfferSuccessMoreDateState());
    });
  }

  /// Get All Offer List
  void getOfferList() async {
    emit(OfferLoadingState());
    page = 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOffers(
      page: page,
      limit: 10,
    );
    result.fold((CustomException error) => emit(OfferErrorState(error: error)),
        (List<OrderModel> offerListData) {
      offerList = offerListData;
      hasMoreData = offerList.length == 10;
      if (offerList.isEmpty) {
        emit(OfferEmptyState());
      } else {
        emit(OfferSuccessState());
      }
    });
  }
}
