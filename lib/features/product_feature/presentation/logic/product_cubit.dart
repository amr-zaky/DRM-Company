import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/model/product_model.dart';
import '/features/product_feature/domain/ues_cases/product_ues_cases.dart';
import 'product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit(this._repo) : super(ProductStateInit());

  static ProductCubit get(BuildContext context) => BlocProvider.of(
        context,
      );

  final ProductUesCases _repo;

  bool isNotified = false;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<ProductModel> productList = <ProductModel>[];
  bool hasMoreData = false;

  Future<dynamic> onRefresh() async {
    getProductList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! ProductLoadingMoreDateState && hasMoreData) {
        whenScrollProductPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollProductPagination() async {
    emit(ProductLoadingMoreDateState());

    page = page + 1;
    final Either<CustomException, List<ProductModel>> result =
        await _repo.getProductList(page: page);
    result.fold(
        (CustomException error) =>
            emit(ProductErrorMoreDateState(error: error)),
        (List<ProductModel> productListData) {
      final List<ProductModel> tempList = productListData;
      hasMoreData = tempList.length == 10;
      productList.addAll(tempList);
      emit(ProductSuccessMoreDateState());
    });
  }

  /// Get All notification List
  void getProductList() async {
    emit(ProductLoadingState());
    page = 1;
    final Either<CustomException, List<ProductModel>> result =
        await _repo.getProductList(page: page);
    result.fold((CustomException error) => emit(ProductErrorState()),
        (List<ProductModel> productListData) {
      productList = productListData;
      hasMoreData = productList.length == 10;
      if (productList.isEmpty) {
        emit(ProductEmptyState());
      } else {
        emit(ProductSuccessState());
      }
    });
  }
}
