import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:base_project_repo/features/order_feature/domain/order_model.dart';
import 'package:dartz/dartz.dart';

import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';
import '/features/order_feature/domain/repository/order_repository_interface.dart';

class OrdersUesCases {
  OrdersUesCases(this.repositoryInterface);

  final OrdersRepositoryInterface repositoryInterface;

  Future<Either<CustomException, SuccessModel>> createNewOrder({
    required String addressId,
    required String productId,
    required String quantity,
    required String date,
  }) async {
    try {
      final Either<CustomException, BaseModel> result =
          await repositoryInterface.createNewOrder(
              addressId: addressId,
              productId: productId,
              quantity: quantity,
              date: date);

      return result.fold(
        (CustomException l) => left(l),
        (BaseModel r) => right(SuccessModel()),
      );
    } catch (e) {
      // Handle any other exceptions that might occur
      return left(
        CustomException(
          CustomStatusCodeErrorType.unExcepted,
          errorMassage: e.toString(),
        ),
      );
    }
  }

  Future<Either<CustomException, List<OrderModel>>> getOrders({
    required int page,
    required int limit,
    required OrderType orderType,
  }) async {
    try {
      final Either<CustomException, BaseModel> result =
          await repositoryInterface.getOrders(
              page: page, limit: limit, orderType: orderType);

      return result.fold(
        (CustomException l) => left(l),
        (BaseModel r) => right(
          orderListFromJson(
            r.data,
          ),
        ),
      );
    } catch (e) {
      // Handle any other exceptions that might occur
      return left(
        CustomException(
          CustomStatusCodeErrorType.unExcepted,
          errorMassage: e.toString(),
        ),
      );
    }
  }

  Future<Either<CustomException, SuccessModel>> updateStatus(
      {required int orderId, required OrderStatus orderStatus}) async {
    try {
      final Either<CustomException, BaseModel> result =
          await repositoryInterface.updateStatus(
              orderId: orderId, orderStatus: orderStatus);

      return result.fold(
        (CustomException l) => left(l),
        (BaseModel r) => right(
          SuccessModel(),
        ),
      );
    } catch (e) {
      // Handle any other exceptions that might occur
      return left(
        CustomException(
          CustomStatusCodeErrorType.unExcepted,
          errorMassage: e.toString(),
        ),
      );
    }
  }
}
