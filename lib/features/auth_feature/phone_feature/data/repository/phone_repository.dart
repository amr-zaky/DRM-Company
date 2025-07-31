import 'package:dartz/dartz.dart';

import '../../domain/interface/phone_interface.dart';
import '../data_source/phone_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

class PhoneRepository extends PhoneInterface {
  PhoneRepository(
      {required this.phoneDataSource,
      required this.connectionCheckerInterface});
  final PhoneDataSource phoneDataSource;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, BaseModel>> changePhoneNumber(
      {required AuthEntity entity}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          return phoneDataSource.changePhoneNumber(entity: entity);
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
