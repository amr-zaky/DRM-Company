import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error_handling/custom_exception.dart';
import '/features/order_feature/domain/order_model.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import 'home_offer_states.dart';

class HomeOfferCubit extends Cubit<HomeOfferStates> {
  HomeOfferCubit(this._repo) : super(OfferStateInit());

  static HomeOfferCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final OrdersUesCases _repo;

  ///pagination
  int page = 1;
  List<OrderModel> offerList = <OrderModel>[];

  Future<dynamic> onRefresh() async {
    getHomeOfferList();
  }

  /// Pagination Function

  /// Get All Offer List
  void getHomeOfferList() async {
    emit(HomeOfferLoadingState());
    page = 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOffers(
      page: page,
      limit: 2,
    );
    result.fold((CustomException error) => emit(HomeOfferErrorState(error: error)),
        (List<OrderModel> offerListData) {
      offerList = offerListData;
      if (offerList.isEmpty) {
        emit(HomeOfferEmptyState());
      } else {
        emit(HomeOfferSuccessState());
      }
    });
  }
}
