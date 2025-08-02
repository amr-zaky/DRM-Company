import 'package:dartz/dartz.dart';

import '../repository/delete_account_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/reason_model.dart';
import '/core/model/success_model.dart';

class DeleteAccountUseCase {
  DeleteAccountUseCase(this.reasonsInterface);
  final DeleteAccountInterface reasonsInterface;

  Future<Either<CustomException, List<ReasonModel>>> getReasons() async {
    return reasonsInterface.getDeleteAccountReasons();
  }

  Future<Either<CustomException, SuccessModel>> deleteAccount(
      {required String reason, required String reasonNote}) async {
    return reasonsInterface.deleteAccount(
        reason: reason, reasonNote: reasonNote);
  }
}
