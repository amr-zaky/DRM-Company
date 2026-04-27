import 'dart:ui';

import 'package:base_project_repo/core/constants/app_constants.dart';
import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/filter_feature/presentation/select_item_pop_up.dart';
import 'package:base_project_repo/core/helpers/shared.dart';
import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:base_project_repo/core/model/product_model.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/common_app_bar_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_cached_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:base_project_repo/core/presentation/widgets/common_title_text.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_bottom_sheet.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_snack_bar.dart';
import 'package:base_project_repo/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_states.dart';
import 'package:base_project_repo/features/product_feature/presentation/logic/product_cubit.dart';
import 'package:base_project_repo/features/product_feature/presentation/logic/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeAddressCubit homeAddressCubit;

  @override
  void initState() {
    super.initState();
    ProductCubit.get(context).getProductList();
    homeAddressCubit = HomeAddressCubit.get(context);
    homeAddressCubit.getAddressList();
    ProductCubit.get(context).scrollController = ScrollController()
      ..addListener(() {
        ProductCubit.get(context).setupScrollController();
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        withBack: false,
        centerTitle: false,
        leadingWidth: getWidgetWidth(AppConstants.padding16),
        customTitleWidget: _buildAppBarTitle(),
        withNotification: true,
      ),
      body: Column(
        children: <Widget>[
          getSpaceHeight(AppConstants.padding32),
          _buildPromoBanner(),
          getSpaceHeight(AppConstants.padding16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblContainers,
                ),
              ],
            ),
          ),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }
  Widget _buildAppBarTitle() {
    return Row(
      children: <Widget>[
        ClipOval(
          child: CommonCachedImageWidget(
            imageUrl: SharedText.currentUser?.image ?? "",
            width: 32,
            height: 32,
            fit: BoxFit.cover,
            isProfile: true,
          ),
        ),
        getSpaceWidth(AppConstants.padding4),
        BlocConsumer<HomeAddressCubit, HomeAddressStates>(
          listener: _onAddressStateChanged,
          builder: _buildAddressSection,
        ),
      ],
    );
  }

  void _onAddressStateChanged(BuildContext context, HomeAddressStates state) {
    if (state is HomeAddressErrorState) {
      showSnackBar(context: context, title: state.error!.errorMassage);
      checkUserAuth(context: context, errorType: state.error!.type);
    }
  }

  Widget _buildAddressSection(BuildContext context, HomeAddressStates state) {
    if (state is HomeAddressLoadingState) {
      return const LoadingShimmer(height: 32, width: 100);
    }

    if (state is HomeAddressErrorState) {
      return CommonTitleText(
        textKey: AppLocalizations.of(context)!.lblWrongHappen,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonTitleText(
          textKey: SharedText.currentUser?.name ?? "---",
          textFontSize: AppConstants.fontSize12,
        ),
        if (state is HomeAddressEmptyState)
          _buildEmptyAddressButton()
        else
          _buildAddressSelector(),
      ],
    );
  }

  Widget _buildEmptyAddressButton() {
    return InkWell(
      onTap: () => _showAddAddressBottomSheet(),
      child: _buildAddressRow(
        AppLocalizations.of(context)!.lblNoAddressYet,
      ),
    );
  }

  void _showAddAddressBottomSheet() {
    showBottomModalSheet(
      context: context,
      children: [
        getSpaceHeight(AppConstants.padding24),
        CommonAssetSvgImageWidget(
          imageString: IconPath.locationIcon,
          height: 48,
          width: 48,
        ),
        getSpaceHeight(AppConstants.padding16),
        CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblAddYourLocation,
          textFontSize: AppConstants.fontSize18,
        ),
        Padding(
          padding: const EdgeInsets.all(AppConstants.padding16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CommonTitleText(
                  textKey:
                  AppLocalizations.of(context)!.lblAddNewAddressDesc,
                  textFontSize: AppConstants.fontSize14,
                  lines: 2,
                  textAlignment: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        CommonGlobalButton(
          buttonText: AppLocalizations.of(context)!.lblAddAddress,
          onPressedFunction: () {
            context.pushNamed(
              RouteNames.addNewAddressPageRoute,
              extra: RouteArgument(),
            );
          },
          buttonBackgroundColor: AppConstants.mainTextColor,
          height: 40,
        ),
        getSpaceHeight(AppConstants.padding32),
      ],
    );
  }

  Widget _buildAddressSelector() {
    return InkWell(
      onTap: () {
        advancedSearchPopUP(
            context: context,
            title:
            AppLocalizations.of(context)!.lblYourLocation,
            onApply: (address) {
              homeAddressCubit.setSelectedAddress(address);
            },
            selectedModel:
            homeAddressCubit.selectedAddressModel,
            listOfItem: homeAddressCubit.addressList,
            isListHaveSearch: false,
            heightFactor: 0.50);
      },
      child: _buildAddressRow(
        homeAddressCubit.selectedAddressModel?.name ?? "---",
      ),
    );
  }

  Widget _buildAddressRow(String addressText) {
    return Row(
      children: <Widget>[
        CommonTitleText(
          textKey: addressText,
          textFontSize: AppConstants.fontSize10,
          textColor: AppConstants.mainColor,
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: AppConstants.fontSize16,
          color: AppConstants.appBarTitleColor,
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    bool isArabic = Directionality.of(context) == TextDirection.rtl;

    return SizedBox(
      height: getWidgetHeight(105),
      width: getWidgetWidth(343),
      child: Stack(
        children: [

          const Opacity(
            opacity: 0.4,
            child: CommonAssetSvgImageWidget(
              imageString: IconPath.backGroundPatternIcon,
              height: 88,
              width: 343,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblRDM,
                        textWeight: FontWeight.w500,
                      ),
                      getSpaceHeight(AppConstants.padding4),
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!
                            .lblWeMoveYourContainer,
                        textWeight: FontWeight.w500,
                        textColor: AppConstants.greenColor,
                        textFontSize: AppConstants.fontSize14,
                      ),
                    ],
                  ),
                ),

                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(isArabic ? -1.0 : 1.0, 1.0)
                    ..translate(isArabic ? 30.0 : 20.0, 0.0),
                  child: const CommonAssetSvgImageWidget(
                    imageString: IconPath.rdmIcon,
                    height: 100,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: _onProductStateChanged,
      builder: _buildProductGridContent,
    );
  }

  void _onProductStateChanged(BuildContext context, ProductStates state) {
    if (state is ProductErrorState) {
      showSnackBar(context: context, title: state.error!.errorMassage);
      checkUserAuth(context: context, errorType: state.error!.type);
    } else if (state is ProductErrorMoreDateState) {
      showSnackBar(context: context, title: state.error!.errorMassage);
      checkUserAuth(context: context, errorType: state.error!.type);
    }
  }

  Widget _buildProductGridContent(
      BuildContext context, ProductStates state) {
    if (state is ProductLoadingState) {
      return _buildShimmerGrid();
    }

    if (state is ProductSuccessState) {
      return _buildProductList();
    }

    return const Center(child: Text("No Data"));
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.padding16),
      itemCount: 4,
      gridDelegate: _gridDelegate(),
      itemBuilder: (_, __) => const LoadingShimmer(),
    );
  }

  Widget _buildProductList() {
    final products = ProductCubit.get(context).productList;
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.padding16),
      itemCount: products.length,
      gridDelegate: _gridDelegate(),
      itemBuilder: (_, index) => _buildProductCard(products[index]),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          RouteNames.productDetailsPageRoute,
          extra: RouteArgument(productModel: product),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppConstants.shadowColor,
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppConstants.padding8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CommonCachedImageWidget(
              imageUrl: product.image ?? "",
              width: 164,
              height: 113,
              fit: BoxFit.contain,
            ),
            CommonTitleText(
              textKey: product.name ?? "---",
              textFontSize: AppConstants.fontSize14,
              textColor: AppConstants.greenColor,
              textWeight: FontWeight.w500,
            ),
            CommonTitleText(
              textKey:
              "${product.price} ${AppLocalizations.of(context)!.lblCurrency}",
              textFontSize: AppConstants.fontSize12,
              textColor: AppConstants.mainTextColor,
              textWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: AppConstants.padding8,
      crossAxisSpacing: AppConstants.padding8,
      childAspectRatio: 0.93,
    );
  }

}