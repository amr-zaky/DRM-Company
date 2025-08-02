import 'package:dartz/dartz.dart';

import '../interface/phone_interface.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/auth_base_entity.dart';
import '/core/model/base_model.dart';

class PhoneUseCase {
  PhoneUseCase(this._phoneInterface);
  final PhoneInterface _phoneInterface;

  Future<Either<CustomException, BaseModel>> changePhone({
    required AuthEntity entity,
  }) async {
    return _phoneInterface.changePhoneNumber(entity: entity);
  }
}
