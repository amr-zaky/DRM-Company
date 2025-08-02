import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:base_project_repo/features/home_feature/logic/home_offers_cubit/home_offer_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_offers_cubit/home_offer_states.dart';
import 'package:base_project_repo/features/order_feature/domain/order_model.dart';
import 'package:base_project_repo/features/order_feature/presentation/widget/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/feature/bottom_nav/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';

class HomeOffers extends StatelessWidget {
  const HomeOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocConsumer<HomeOfferCubit, HomeOfferStates>(
          listener: (BuildContext context, HomeOfferStates state) {
            if (state is HomeOfferErrorState) {
              checkUserAuth(context: context, errorType: state.error!.type);
            }
          },
          builder: (BuildContext context, HomeOfferStates state) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblNewestOffer,
                        textWeight: FontWeight.w600,
                        textColor: AppConstants.appBarTitleColor,

                      ),
                      if (HomeOfferCubit.get(context).offerList.length >
                          1) ...<Widget>[
                        InkWell(
                          onTap: () {
                            BottomNavCubit.get(context).selectItem(1);
                          },
                          child: CommonTitleText(
                            textKey: AppLocalizations.of(context)!.lblShowMore,
                            textFontSize: AppConstants.fontSize10,
                            textColor: AppConstants.lightGrayBackgroundColor,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                getSpaceHeight(AppConstants.padding8),
                if (state is HomeOfferLoadingState) ...<Widget>[
                  SizedBox(
                    height: 3 * getWidgetHeight(120),
                    width: SharedText.screenWidth,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(
                        AppConstants.padding16,
                      ),
                      itemBuilder: (BuildContext itemCtx, int itemPos) {
                        return const LoadingShimmer(
                          height: 110,
                        );
                      },
                      itemCount: 3,
                      separatorBuilder: (BuildContext context, int index) {
                        return getSpaceHeight(AppConstants.padding8);
                      },
                    ),
                  ),
                ] else if (state is HomeOfferSuccessState) ...<Widget>[
                  SizedBox(
                    height: HomeOfferCubit.get(context).offerList.length *
                        getWidgetHeight(110),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(
                        AppConstants.padding16,
                      ),
                      itemBuilder: (BuildContext itemCtx, int itemPos) {
                        final OrderModel orderModel =
                            HomeOfferCubit.get(context).offerList[itemPos];
                        return OfferItem(offerModel: orderModel);
                      },
                      itemCount: HomeOfferCubit.get(context).offerList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return getSpaceHeight(AppConstants.padding8);
                      },
                    ),
                  )
                ] else ...<Widget>[
                  EmptyScreen(
                    imageString: IconPath.wrongIcon,
                    imageHeight: 100,
                    imageWidth: 110,
                    titleKey: AppLocalizations.of(context)!.lblNoOffers,
                  )
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
