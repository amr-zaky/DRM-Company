import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/constants/enums/order_type.dart';

import '/features/order_feature/domain/repository/order_repository_interface.dart';
import 'package:dartz/dartz.dart';

import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';
import '../data_source/remote_data_source.dart';

class OrdersRepositoryImp extends OrdersRepositoryInterface {
  OrdersRepositoryImp(
      {required this.remoteDataScoursInterface,
      required this.connectionCheckerInterface});

  final OrderRemoteDataScoursInterface remoteDataScoursInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, BaseModel>> createNewOrder({
    required String addressId,
    required String productId,
    required String quantity,
    required String date,
  }) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.createNewOrder(
              addressId: addressId,
              productId: productId,
              quantity: quantity,
              date: date);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> getOrders(
      {required int page, required int limit, required OrderType orderType}) {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.getOrders(
              page: page, limit: limit, orderType: orderType);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> updateStatus(
      {required int orderId, required OrderStatus orderStatus}) {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.updateStatus(
            orderId: orderId,
            orderStatus: orderStatus,
          );
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
