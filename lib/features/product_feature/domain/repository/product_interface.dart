import '/core/model/product_model.dart';
import 'package:dartz/dartz.dart';

import '/core/error_handling/custom_exception.dart';

abstract class ProductInterface {
  Future<Either<CustomException, List<ProductModel>>> getProductList(
      {required int page, int? limit});
}
