import 'package:base_project_repo/core/model/address_model.dart';
import 'package:base_project_repo/core/model/success_model.dart';
import 'package:base_project_repo/features/address_feature/domain/repository/address_interface.dart';
import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';

class AddressUesCases {
  AddressUesCases(this.repositoryInterface);

  final AddressInterface repositoryInterface;

  Future<Either<CustomException, List<AddressModel>>> getAddressList(
      {required int page, int? limit}) {
    return repositoryInterface
        .getAddressList(page: page, limit: limit ?? 10)
        .then((Either<CustomException, List<AddressModel>> value) => value.fold(
            (CustomException l) => left(l),
            (List<AddressModel> r) => right(r)));
  }

  Future<Either<CustomException, SuccessModel>> addNewAddress({
    required double lat,
    required double lng,
    required String addressName,
    required String fullAddress,
    int? isDefault,
  }) {
    return repositoryInterface
        .addNewAddress(
            lat: lat,
            lng: lng,
            addressName: addressName,
            fullAddress: fullAddress,
            isDefault: isDefault)
        .then((Either<CustomException, SuccessModel> value) => value.fold(
            (CustomException l) => left(l),
            (SuccessModel r) => right(SuccessModel())));
  }
}
