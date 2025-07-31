import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';

import '/core/model/reason_model.dart';
import '/core/model/success_model.dart';

abstract class DeleteAccountInterface {
  Future<Either<CustomException, List<ReasonModel>>> getDeleteAccountReasons();

  Future<Either<CustomException, SuccessModel>> deleteAccount(
      {required String reason, required String reasonNote});
}
