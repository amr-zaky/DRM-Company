import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_states.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/create_order_cubit/create_order_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/create_order_cubit/create_order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_cached_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.routeArgument,
  });

  final RouteArgument routeArgument;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late HomeAddressCubit homeAddressCubit;
  late CreateOrderCubit createOrderCubit;

  @override
  void initState() {
    super.initState();
    homeAddressCubit = HomeAddressCubit.get(context);
    createOrderCubit = CreateOrderCubit.get(context);
    createOrderCubit.init();
    if (homeAddressCubit.selectedAddressModel != null) {
      createOrderCubit
          .updateSelectedAddress(homeAddressCubit.selectedAddressModel!);
    }
    createOrderCubit.updateSelectedProduct(widget.routeArgument.productModel!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        leadingWidth: getWidgetWidth(AppConstants.padding16),
        customTitleWidget: CommonTitleText(
          textKey: widget.routeArgument.productModel?.name ?? "---",
          textWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBar: Container(
        height: getWidgetHeight(88),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.padding8),
            topRight: Radius.circular(AppConstants.padding8),
          ),
          color: AppConstants.lightWhiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppConstants.shadowColor,
              blurRadius: 4,
            ),
          ],
        ),
        child: BlocBuilder<CreateOrderCubit, OrderStates>(
          builder: (BuildContext context, OrderStates state) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.padding16,
                  vertical: AppConstants.padding16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const CommonAssetSvgImageWidget(
                          imageString: IconPath.moneyIcon,
                          height: 24,
                          width: 24,
                        ),
                        CommonTitleText(
                          textKey:
                              "${(widget.routeArgument.productModel?.price ?? 0) * createOrderCubit.quantity}  ",
                          textWeight: FontWeight.w700,
                          textColor: AppConstants.successColor,
                        ),
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblCurrency,
                          textWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppConstants.padding8),
                              topRight: Radius.circular(AppConstants.padding8),
                            ),
                            color: AppConstants.lightWhiteColor,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppConstants.shadowColor,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          width: getWidgetWidth(96),
                          height: getWidgetHeight(32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: getWidgetWidth(24),
                                height: getWidgetHeight(24),
                                child: InkWell(
                                    onTap: () {
                                      createOrderCubit.increaseQuantity();
                                    },
                                    child: const Icon(Icons.add)),
                              ),
                              CommonTitleText(
                                textKey: createOrderCubit.quantity.toString(),
                                textWeight: FontWeight.w700,
                                textColor: AppConstants.mainColor,
                              ),
                              SizedBox(
                                width: getWidgetWidth(24),
                                height: getWidgetHeight(24),
                                child: InkWell(
                                    onTap: () {
                                      createOrderCubit.decreaseQuantity();
                                    },
                                    child: const Icon(Icons.remove)),
                              )
                            ],
                          ),
                        ),
                        getSpaceWidth(AppConstants.padding4),
                        CommonGlobalButton(
                          width: 90,
                          height: 32,
                          buttonText: AppLocalizations.of(context)!.lblOrderNow,
                          buttonBackgroundColor: AppConstants.appBarTitleColor,
                          buttonTextSize: AppConstants.fontSize16,
                          onPressedFunction: () {
                            context.pushNamed(RouteNames.orderConfirmPageRoute);
                          },
                        )
                      ],
                    )
                  ],
                ));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.padding16,
        ),
        child: Column(
          children: <Widget>[
            getSpaceHeight(AppConstants.padding8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: getWidgetWidth(343),
                  height: getWidgetHeight(260),
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
                  child: CommonCachedImageWidget(
                    imageUrl: widget.routeArgument.productModel?.image ?? "",
                    width: 164,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            getSpaceHeight(
              AppConstants.padding16,
            ),
            Row(
              children: <Widget>[
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblAboutProduct,
                  textWeight: FontWeight.w500,
                ),
              ],
            ),
            getSpaceHeight(AppConstants.padding16),
            Row(
              children: <Widget>[
                Expanded(
                  child: CommonTitleText(
                    textKey:
                        widget.routeArgument.productModel?.description ?? "---",
                    lines: 8,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
