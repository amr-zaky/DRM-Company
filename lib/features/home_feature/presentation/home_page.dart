import 'dart:ui';

import 'package:base_project_repo/core/constants/app_constants.dart';
import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/filter_feature/presentation/select_item_pop_up.dart';
import 'package:base_project_repo/core/helpers/shared.dart';
import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:base_project_repo/core/model/product_model.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/Alert_Dialogs/guest_mode_dialog.dart';
import 'package:base_project_repo/core/presentation/widgets/common_app_bar_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_cached_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:base_project_repo/core/presentation/widgets/common_title_text.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_bottom_sheet.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_snack_bar.dart';
import 'package:base_project_repo/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_states.dart';
import 'package:base_project_repo/features/home_feature/logic/home_offers_cubit/home_offer_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_orders_cubit/home_order_cubit.dart';
import 'package:base_project_repo/features/home_feature/widget/home_offers.dart';
import 'package:base_project_repo/features/home_feature/widget/home_orders.dart';
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
    HomeOfferCubit.get(context).getHomeOfferList();
    HomeOrderCubit.get(context).getHomeOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: getWidgetHeight(180), // Adjust height as needed

                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppConstants.lightBlackColor.withOpacity(0.08),
                        blurRadius: 8)
                  ],
                  gradient: AppConstants.customGradient,
                ),
                child: SafeArea(
                  bottom: false,
                  top: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.padding16) +
                        EdgeInsets.only(bottom: AppConstants.padding20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CommonTitleText(
                                textKey:
                                    "${AppLocalizations.of(context)!.lblWelcome} ",
                                textFontSize: AppConstants.fontSize24,
                                textColor: AppConstants.lightWhiteColor,
                                textWeight: FontWeight.w700,
                              ),
                              getSpaceHeight(AppConstants.padding8),
                              CommonTitleText(
                                textKey:
                                    "${SharedText.currentUser?.name ?? "---"}",
                                textFontSize: AppConstants.fontSize24,
                                textColor: AppConstants.lightWhiteColor,
                                textWeight: FontWeight.w700,
                              ),
                              getSpaceHeight(AppConstants.padding8),
                            ],
                          ),
                        ),
                        const CommonAssetImageWidget(
                            imageString: IconPath.homeWelcomeIcon,
                            height: 110,
                            fit: BoxFit.fill,
                            width: 160)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: getWidgetHeight(160),
              // Adjust for desired overlap
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppConstants.lightWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.borderRadius24),
                    topRight: Radius.circular(AppConstants.borderRadius24),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppConstants.shadowColor,
                        blurRadius: 8,
                        offset: Offset(0, -4)),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      getSpaceHeight(AppConstants.padding12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.padding16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CommonTitleText(
                              textKey:
                              AppLocalizations.of(context)!
                                  .lblDRM,
                              textFontSize: AppConstants.fontSize20,
                              textWeight: FontWeight.w700,
                            ),
                            InkWell(
                              onTap: () {
                                if (SharedText.isGuestMode) {
                                  showGuestModeAlertDialog(context);
                                } else {
                                  context.pushNamed(
                                      RouteNames.notificationPageRoute);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 4),
                                child: CommonAssetSvgImageWidget(
                                    imageString: IconPath.notificationIcon,
                                    height: 24,
                                    imageColor: AppConstants.mainColor,
                                    width: 24),
                              ),
                            ),
                          ],
                        ),
                      ),

                      getSpaceHeight(AppConstants.padding16),
                      const HomeOffers(),
                      getSpaceHeight(AppConstants.padding16),
                      const HomeOrders(),
                      getSpaceHeight(AppConstants.padding36),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
