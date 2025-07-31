import 'package:base_project_repo/core/model/product_model.dart';
import 'package:base_project_repo/features/product_feature/domain/repository/product_interface.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/connectivity/connection_checker.dart';
import '/core/model/base_model.dart';

class ProductRepository extends ProductInterface {
  ProductRepository(
      {required this.remoteDataScoursInterface,
      required this.connectionCheckerInterface});

  final ProductRemoteDataScoursInterface remoteDataScoursInterface;
  final ConnectionCheckerInterface connectionCheckerInterface;

  @override
  Future<Either<CustomException, List<ProductModel>>> getProductList(
      {required int page, int? limit}) async {
    return connectionCheckerInterface.isConnected().then(
      (bool value) async {
        if (value) {
          final Either<CustomException, BaseModel> result =
              await remoteDataScoursInterface.getProductList(page: page);
          return result.fold((CustomException l) => left(l), (BaseModel base) {
            return right(productListFromJson(base.data));
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
