import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:base_project_repo/core/constants/keys/api_keys.dart';
import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:base_project_repo/features/order_feature/domain/order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class OrderRemoteDataScoursInterface {
  Future<Either<CustomException, BaseModel>> createNewOrder({
    required String addressId,
    required String productId,
    required String quantity,
    required String date,
  });

  Future<Either<CustomException, BaseModel>> getOrders(
      {required int page, required int limit, required OrderType orderType});

  Future<Either<CustomException, BaseModel>> getOffers({
    required int page,
    required int limit,
  });

  Future<Either<CustomException, BaseModel>> updateStatus({
    required int orderId,
    required OrderStatus orderStatus,
  });
}

class OrdersRemoteDataScoursImp extends OrderRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, BaseModel>> createNewOrder({
    required String addressId,
    required String productId,
    required String quantity,
    required String date,
  }) async {
    try {
      const String questionUrl = ApiKeys.orderKey;
      final Map<String, dynamic> data = <String, dynamic>{
        "account_address_id": addressId,
        "product_id": productId,
        "quantity": quantity,
        "date": date,
      };
      print("data$data");
      final FormData formData =
          FormData.fromMap(data, ListFormat.multiCompatible);
      final Response<dynamic> response =
          await DioHelper.postData(url: questionUrl, data: formData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getOrders(
      {required int page,
      required int limit,
      required OrderType orderType}) async {
    try {
      String questionUrl;
      switch (orderType) {
        case OrderType.oldOrders:
          questionUrl = "${ApiKeys.orderHistoryKey}?page=$page&limit=$limit";
        case OrderType.newOrders:
          questionUrl = "${ApiKeys.orderCurrentKey}?page=$page&limit=$limit";
      }
      print(questionUrl);

      final Response<dynamic> response = await DioHelper.getDate(
        url: questionUrl,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getOffers({
    required int page,
    required int limit,
  }) async {
    try {
      String questionUrl = "${ApiKeys.offerKey}?page=$page&limit=$limit";

      print(questionUrl);

      final Response<dynamic> response = await DioHelper.getDate(
        url: questionUrl,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> updateStatus(
      {required int orderId, required OrderStatus orderStatus}) async {
    try {
      String questionUrl = ApiKeys.updateOrderKey +
          "/$orderId?status=${orderStatus.getStatusValueInApi()}&provider_id=${SharedText.currentUser?.id}";
      print(questionUrl);
      final FormData formData = FormData();

      final Response<dynamic> response = await DioHelper.putData(
        url: questionUrl,
        data: formData,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
