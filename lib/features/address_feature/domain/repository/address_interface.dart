import 'package:dartz/dartz.dart';

import '../../../../core/model/success_model.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/address_model.dart';

abstract class AddressInterface {
  Future<Either<CustomException, List<AddressModel>>> getAddressList(
      {required int page, int? limit});

  Future<Either<CustomException, SuccessModel>> addNewAddress({
    required double lat,
    required double lng,
    required String addressName,
    required String fullAddress,
    int? isDefault,
  });
}
