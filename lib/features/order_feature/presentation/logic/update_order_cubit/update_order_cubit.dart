import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error_handling/custom_exception.dart';
import '/features/order_feature/domain/order_model.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import 'update_orders_states.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderStates> {
  UpdateOrderCubit(this._repo) : super(UpdateOrderStateInit());

  static UpdateOrderCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final OrdersUesCases _repo;

  /// Get All Order List
  void updateServices(
    OrderModel orderModel,
    OrderStatus orderStatus,
  ) async {
    emit(UpdateOrderLoadingState());
    final Either<CustomException, SuccessModel> result = await _repo
        .updateStatus(orderId: orderModel.id, orderStatus: orderStatus);
    result.fold(
        (CustomException error) => emit(UpdateOrderErrorState(error: error)),
        (SuccessModel successModel) {
      emit(UpdateOrderSuccessState());
    });
  }
}
