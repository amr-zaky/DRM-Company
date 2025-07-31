import 'package:dartz/dartz.dart';

import '../../domain/repository/delete_account_interface.dart';
import '../data_source/delete_account_data_sources.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';
import '/core/model/reason_model.dart';
import '/core/model/success_model.dart';

class DeleteAccountRepository extends DeleteAccountInterface {
  DeleteAccountRepository(
      {required this.dataSource,
      required this.auhLocalDataSourceInterface,
      required this.connectionCheckerInterface});

  final DeleteAccountDataSource dataSource;
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, List<ReasonModel>>>
      getDeleteAccountReasons() async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return dataSource.getDeleteAccountReasons().then(
              (Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException l) async {
                    return left(l);
                  }, (BaseModel r) async {
                    final List<ReasonModel> reasons =
                        reasonListFromJson(r.data);
                    return right(reasons);
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> deleteAccount(
      {required String reason, required String reasonNote}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return dataSource
              .deleteAccount(reason: reason, reasonNote: reasonNote)
              .then((Either<CustomException, BaseModel> value) =>
                  value.fold((CustomException l) => left(l), (BaseModel r) {
                    ///remove the user model from cache
                    auhLocalDataSourceInterface.deleteCachedUser();

                    ///delete user token from Auth header
                    dataSource.deleteAuthToken();

                    return right(SuccessModel());
                  }));
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
