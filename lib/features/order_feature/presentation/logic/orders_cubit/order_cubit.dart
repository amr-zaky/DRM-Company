import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error_handling/custom_exception.dart';
import '/features/order_feature/domain/order_model.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import 'orders_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this._repo) : super(OrderStateInit());

  static OrderCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final OrdersUesCases _repo;

  OrderType orderType = OrderType.newOrders;

  void initOrderCubit() {
    orderType = OrderType.newOrders;
    emit(OrderStateInit());
  }

  void updateOrderType(OrderType newOrderType) {
    orderType = newOrderType;
    emit(OrderStateInit());
  }

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<OrderModel> orderList = <OrderModel>[];
  bool hasMoreData = false;

  Future<dynamic> onRefresh() async {
    getOrderList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! OrderLoadingMoreDateState && hasMoreData) {
        whenScrollOrderPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollOrderPagination() async {
    emit(OrderLoadingMoreDateState());

    page = page + 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOrders(
      page: page,
      limit: 10,
      orderType: orderType,
    );
    result.fold(
        (CustomException error) => emit(OrderErrorMoreDateState(error: error)),
        (List<OrderModel> orderListData) {
      final List<OrderModel> tempList = orderListData;
      hasMoreData = tempList.length == 10;
      orderList.addAll(tempList);
      emit(OrderSuccessMoreDateState());
    });
  }

  /// Get All Order List
  void getOrderList() async {
    emit(OrderLoadingState());
    page = 1;
    final Either<CustomException, List<OrderModel>> result =
        await _repo.getOrders(
      page: page,
      limit: 10,
      orderType: orderType,
    );
    result.fold((CustomException error) => emit(OrderErrorState(error: error)),
        (List<OrderModel> orderListData) {
      orderList = orderListData;
      hasMoreData = orderList.length == 10;
      if (orderList.isEmpty) {
        emit(OrderEmptyState());
      } else {
        emit(OrderSuccessState());
      }
    });
  }
}
