import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:base_project_repo/features/order_feature/domain/order_model.dart';
import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class OrdersRepositoryInterface {
  Future<Either<CustomException, BaseModel>> createNewOrder({
    required String addressId,
    required String productId,
    required String quantity,
    required String date,
  });

  Future<Either<CustomException, BaseModel>> getOrders({
    required int page,
    required int limit,
    required OrderType orderType,
  });

  Future<Either<CustomException, BaseModel>> getOffers({
    required int page,
    required int limit,
  });

  Future<Either<CustomException, BaseModel>> updateStatus({
    required int orderId,
    required OrderStatus orderStatus,
  });
}
