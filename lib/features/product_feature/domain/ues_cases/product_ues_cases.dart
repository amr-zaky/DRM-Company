import 'package:base_project_repo/core/model/product_model.dart';
import 'package:base_project_repo/features/product_feature/domain/repository/product_interface.dart';
import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';

class ProductUesCases {
  ProductUesCases(this.repositoryInterface);

  final ProductInterface repositoryInterface;

  Future<Either<CustomException, List<ProductModel>>> getProductList(
      {required int page, int? limit}) {
    return repositoryInterface
        .getProductList(page: page, limit: limit ?? 10)
        .then((Either<CustomException, List<ProductModel>> value) => value.fold(
            (CustomException l) => left(l),
            (List<ProductModel> r) => right(r)));
  }
}
