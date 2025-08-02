import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/constants/keys/api_keys.dart';
import '/core/data_source/network/dio_helper.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/base_model.dart';

abstract class TicketRemoteDataScoursInterface {
  Future<Either<CustomException, BaseModel>> getTicketsList(
      {required int page, int? limit});

  Future<Either<CustomException, BaseModel>> openTicket(
      {required int reasonId, required String note, required String subject});

  Future<Either<CustomException, BaseModel>> getTicketComments(
      {required String ticketId});

  Future<Either<CustomException, BaseModel>> getTicketCategory();

  Future<Either<CustomException, BaseModel>> sendComment({
    required String ticketId,
    required String comment,
  });
}

class TicketRemoteDataScoursImp extends TicketRemoteDataScoursInterface {
  @override
  Future<Either<CustomException, BaseModel>> getTicketsList(
      {required int page, int? limit}) async {
    try {
      String ticketUrl;
      if (limit == null) {
        ticketUrl = '${ApiKeys.ticketList}?page=$page';
      } else {
        ticketUrl = '${ApiKeys.ticketList}?page=$page&limit=$limit';
      }
      final Response<dynamic> response =
          await DioHelper.getDate(url: ticketUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> openTicket(
      {required int reasonId,
      required String note,
      required String subject}) async {
    try {
      final FormData data = FormData();
      data.fields.add(
        MapEntry<String, String>(
          'ticket_category_id',
          reasonId.toString(),
        ),
      );
      data.fields.add(MapEntry<String, String>('message', subject));
      data.fields.add(MapEntry<String, String>('title', note));

      final Response<dynamic> response =
          await DioHelper.postData(url: ApiKeys.openTicket, data: data);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getTicketComments(
      {required String ticketId}) async {
    try {
      String ticketChatUrl;
      ticketChatUrl = '${ApiKeys.ticketComments}?filter[ticket_id]=$ticketId';
      final Response<dynamic> response =
          await DioHelper.getDate(url: ticketChatUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> sendComment({
    required String ticketId,
    required String comment,
  }) async {
    try {
      final FormData data = FormData();
      data.fields.add(MapEntry<String, String>('ticket_id', ticketId));
      data.fields.add(MapEntry<String, String>('message', comment));

      final Response<dynamic> response =
          await DioHelper.postData(url: ApiKeys.addComment, data: data);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getTicketCategory() async {
    try {
      final Response<dynamic> response =
          await DioHelper.getDate(url: ApiKeys.ticketCategory);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(ex);
    }
  }
}
