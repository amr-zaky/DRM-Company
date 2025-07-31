import 'package:base_project_repo/core/model/success_model.dart';

import '/core/model/address_model.dart';

import '/features/address_feature/domain/repository/address_interface.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';

class AddressRepository extends AddressInterface {
  AddressRepository(
      {required this.remoteDataScoursInterface,
      required this.connectionCheckerInterface});

  final AddressRemoteDataScoursInterface remoteDataScoursInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, List<AddressModel>>> getAddressList(
      {required int page, int? limit}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          final Either<CustomException, BaseModel> result =
              await remoteDataScoursInterface.getAddressList(page: page);
          return result.fold((CustomException l) => left(l), (BaseModel base) {
            return right(addressListFromJson(base.data));
          });
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }

  @override
  Future<Either<CustomException, SuccessModel>> addNewAddress(
      {required double lat,
      required double lng,
      required String addressName,
      required String fullAddress,
      int? isDefault}) {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          final Either<CustomException, BaseModel> result =
              await remoteDataScoursInterface.addNewAddress(
            lat: lat,
            lng: lng,
            addressName: addressName,
            fullAddress: fullAddress,
            isDefault: isDefault,
          );
          return result.fold((CustomException l) => left(l), (BaseModel base) {
            return right(
                SuccessModel());
          });
        } else {
          return left(CustomException(
            CustomStatusCodeErrorType.internet,
          ));
        }
      },
    );
  }
}
