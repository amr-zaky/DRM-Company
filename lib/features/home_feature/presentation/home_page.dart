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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        customTitleWidget: Row(
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
                listener: (BuildContext context, HomeAddressStates state) {
              if (state is HomeAddressErrorState) {
                showSnackBar(
                    context: context, title: state.error!.errorMassage);
                checkUserAuth(context: context, errorType: state.error!.type);
              }
            }, builder: (BuildContext context, HomeAddressStates state) {
              if (state is HomeAddressLoadingState) {
                return const LoadingShimmer(height: 32, width: 100);
              } else if (state is HomeAddressErrorState) {
                return SizedBox(
                  child: CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblWrongHappen,
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonTitleText(
                      textKey: SharedText.currentUser?.name ?? "---",
                      textFontSize: AppConstants.fontSize12,
                    ),
                    if (state is HomeAddressEmptyState) ...[
                      InkWell(
                        onTap: () {
                          showBottomModalSheet(context: context, children: [
                            getSpaceHeight(AppConstants.padding24),
                            CommonAssetSvgImageWidget(
                                imageString: IconPath.locationIcon,
                                height: 48,
                                width: 48),
                            getSpaceHeight(AppConstants.padding16),
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblAddYourLocation,
                              textFontSize: AppConstants.fontSize18,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblAddNewAddressDesc,
                                      textFontSize: AppConstants.fontSize14,
                                      lines: 2,
                                      textAlignment: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonGlobalButton(
                              buttonText:
                                  AppLocalizations.of(context)!.lblAddAddress,
                              onPressedFunction: () {
                                context.pushNamed(
                                  RouteNames.addNewAddressPageRoute,
                                  extra: RouteArgument(),
                                );
                              },
                              buttonBackgroundColor: AppConstants.mainTextColor,
                              height: 40,
                            ),
                            getSpaceHeight(AppConstants.padding32)
                          ]);
                        },
                        child: SizedBox(
                          child: Row(
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!
                                    .lblNoAddressYet,
                                textFontSize: AppConstants.fontSize10,
                                textColor: AppConstants.mainColor,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: AppConstants.fontSize16,
                                color: AppConstants.appBarTitleColor,
                              )
                            ],
                          ),
                        ),
                      )
                    ] else ...[
                      InkWell(
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
                        child: Row(
                          children: <Widget>[
                            CommonTitleText(
                              textKey:
                                  homeAddressCubit.selectedAddressModel?.name ??
                                      "---",
                              textFontSize: AppConstants.fontSize10,
                              textColor: AppConstants.mainColor,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: AppConstants.fontSize16,
                              color: AppConstants.appBarTitleColor,
                            )
                          ],
                        ),
                      ),
                    ]
                  ],
                );
              }
            }),
          ],
        ),
        withNotification: true,
      ),
      body: Column(
        children: <Widget>[
          getSpaceHeight(AppConstants.padding32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: getWidgetHeight(105),
                width: getWidgetWidth(343),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Opacity(
                      opacity: 0.4,
                      child: CommonAssetSvgImageWidget(
                        imageString: IconPath.backGroundPatternIcon,
                        height: 88,
                        width: 343,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CommonAssetSvgImageWidget(
                          imageString: IconPath.drmIcon,
                          height: 105,
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.padding16,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!.lblDRM,
                                textWeight: FontWeight.w500,
                              ),
                              getSpaceHeight(AppConstants.padding4),
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!
                                    .lblWeMoveYourContainer,
                                textWeight: FontWeight.w500,
                                textColor: AppConstants.greenColor,
                                lines: 2,
                                textFontSize: AppConstants.fontSize14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
          SizedBox(
            height: getWidgetHeight(400),
            width: SharedText.screenWidth,
            child: BlocConsumer<ProductCubit, ProductStates>(
              listener: (BuildContext context, ProductStates state) {
                if (state is ProductErrorState) {
                  showSnackBar(
                      context: context, title: state.error!.errorMassage);
                  checkUserAuth(context: context, errorType: state.error!.type);
                } else if (state is ProductErrorMoreDateState) {
                  showSnackBar(
                      context: context, title: state.error!.errorMassage);
                  checkUserAuth(context: context, errorType: state.error!.type);
                }
              },
              builder: (BuildContext context, ProductStates state) {
                if (state is ProductLoadingState) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(
                      AppConstants.padding16,
                    ),
                    itemBuilder: (BuildContext itemCtx, int itemPos) {
                      return const LoadingShimmer();
                    },
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppConstants.padding8,
                      crossAxisSpacing: AppConstants.padding8,
                    ),
                  );
                } else if (state is ProductSuccessState) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(
                      AppConstants.padding16,
                    ),
                    itemBuilder: (BuildContext itemCtx, int itemPos) {
                      final ProductModel product =
                          ProductCubit.get(context).productList[itemPos];
                      return InkWell(
                        onTap: () {
                          context.pushNamed(
                            RouteNames.productDetailsPageRoute,
                            extra: RouteArgument(
                              productModel: product,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppConstants.lightWhiteColor,
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius8,
                            ),
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
                            children: <Widget>[
                              CommonCachedImageWidget(
                                imageUrl: product.image ?? "",
                                width: 164,
                                height: 113,
                                fit: BoxFit.contain,
                              ),
                              Row(
                                children: <Widget>[
                                  CommonTitleText(
                                    textKey: product.name ?? "---",
                                    textFontSize: AppConstants.fontSize14,
                                    textColor: AppConstants.greenColor,
                                    textWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  CommonTitleText(
                                    textKey: "${product.price.toString()}  " +
                                        AppLocalizations.of(context)!
                                            .lblCurrency,
                                    textFontSize: AppConstants.fontSize12,
                                    textColor: AppConstants.mainTextColor,
                                    textWeight: FontWeight.w700,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: ProductCubit.get(context).productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppConstants.padding8,
                      crossAxisSpacing: AppConstants.padding8,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
