import 'package:dartz/dartz.dart';

import '../../Domain/repository/help_interface.dart';
import '../data_source/remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';
import '/core/model/success_model.dart';

class HelpRepository extends HelpInterface {
  HelpRepository(
      {required this.remoteDataScoursInterface,
      required this.connectionCheckerInterface});
  final HelpRemoteDataScoursInterface remoteDataScoursInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, SuccessModel>> addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.addContact(
            name: name,
            email: email,
            phone: phone,
            subject: subject,
            message: message,
          );
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> getAnswer(
      {required int questionId, required int page, int? limit}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.getAnswer(
              questionId: questionId, page: page);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, BaseModel>> getQuestionList(
      {required int page, int? limit}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) {
        if (value) {
          return remoteDataScoursInterface.getQuestionList(page: page);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
