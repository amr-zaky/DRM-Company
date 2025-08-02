import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error_handling/custom_exception.dart';
import '/features/order_feature/domain/order_model.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import 'home_order_states.dart';

class HomeOrderCubit extends Cubit<HomeOrderStates> {
  HomeOrderCubit(this._repo) : super(OrderStateInit());

  static HomeOrderCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final OrdersUesCases _repo;

  ///pagination
  int page = 1;
  List<OrderModel> orderList = <OrderModel>[];

  Future<dynamic> onRefresh() async {
    getHomeOrderList();
  }

  /// Pagination Function

  /// Get All Order List
  void getHomeOrderList() async {
    emit(HomeOrderLoadingState());
    page = 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOrders(
      page: page,
      limit: 2,
      orderType: OrderType.newOrders,
    );
    result.fold(
        (CustomException error) => emit(HomeOrderErrorState(error: error)),
        (List<OrderModel> orderListData) {
      orderList = orderListData;
      if (orderList.isEmpty) {
        emit(HomeOrderEmptyState());
      } else {
        emit(HomeOrderSuccessState());
      }
    });
  }
}
