import 'package:base_project_repo/core/error_handling/custom_exception.dart';
import 'package:base_project_repo/core/helpers/extensions/format_date_time_to_time_only.dart';
import 'package:base_project_repo/core/model/address_model.dart';
import 'package:base_project_repo/core/model/product_model.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/update_order_cubit/update_orders_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/order_feature/domain/ues_cases/order_cases.dart';
import '/features/order_feature/presentation/logic/create_order_cubit/create_order_states.dart';

class CreateOrderCubit extends Cubit<OrderStates> {
  CreateOrderCubit(this.useCase) : super(OrderInitialState());
  final OrdersUesCases useCase;
  DateTime? dateTime;
  late TextEditingController dateController;
  AddressModel? selectedAddress;
  num quantity = 1;
  ProductModel? selectedProduct;

  void init() {
    quantity = 1;
    dateTime = null;
    selectedAddress = null;
    selectedProduct = null;
    dateController = TextEditingController();
  }

  void updateDateTime(DateTime newDatetime) {
    dateTime = newDatetime;
    emit(OrderUpdateSelectionState());
  }

  void updateSelectedAddress(AddressModel newAddress) {
    selectedAddress = newAddress;
    emit(OrderUpdateSelectionState());
  }

  void updateSelectedProduct(ProductModel newProduct) {
    selectedProduct = newProduct;
    emit(OrderUpdateSelectionState());
  }

  void increaseQuantity() {
    quantity++;
    emit(OrderUpdateSelectionState());
  }

  void decreaseQuantity() {
    quantity >= 2 ? quantity-- : quantity = 1;
    emit(OrderUpdateSelectionState());
  }

  static CreateOrderCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> createOrder() async {
    emit(CreateOrderLoadingState());
    final Either<CustomException, SuccessModel> result =
        await useCase.createNewOrder(
      date: dateTime!.formatDateTimeToBeUserFriendly(),
      addressId: selectedAddress!.id.toString(),
      quantity: quantity.toString(),
      productId: selectedProduct!.id.toString(),
    );
    result.fold((CustomException error) => emit(CreateOrderFailState(error)),
        (SuccessModel successModel) {
      emit(CreateOrderSuccessState());
    });
  }
}
