import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/bottom_nav/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:base_project_repo/features/home_feature/logic/home_orders_cubit/home_order_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_orders_cubit/home_order_states.dart';
import 'package:base_project_repo/features/order_feature/domain/order_model.dart';
import 'package:base_project_repo/features/order_feature/presentation/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';

class HomeOrders extends StatelessWidget {
  const HomeOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocConsumer<HomeOrderCubit, HomeOrderStates>(
          listener: (BuildContext context, HomeOrderStates state) {
            if (state is HomeOrderErrorState) {
              checkUserAuth(context: context, errorType: state.error!.type);
            }
          },
          builder: (BuildContext context, HomeOrderStates state) {
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
                        textKey: AppLocalizations.of(context)!.lblCurrentOrders,
                        textWeight: FontWeight.w600,
                        textColor: AppConstants.appBarTitleColor,
                      ),
                      if (HomeOrderCubit.get(context).orderList.length >
                          1) ...<Widget>[
                        InkWell(
                          onTap: () {
                            BottomNavCubit.get(context).selectItem(2);
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
                if (state is HomeOrderLoadingState) ...<Widget>[
                  SizedBox(
                    height: 3 * getWidgetHeight(200),
                    width: SharedText.screenWidth,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(
                        AppConstants.padding16,
                      ),
                      itemBuilder: (BuildContext itemCtx, int itemPos) {
                        return const LoadingShimmer(
                          height: 180,
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                ] else if (state is HomeOrderSuccessState) ...<Widget>[
                  SizedBox(
                    height: HomeOrderCubit.get(context).orderList.length *
                        getWidgetHeight(200),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(
                        AppConstants.padding16,
                      ),
                      itemBuilder: (BuildContext itemCtx, int itemPos) {
                        final OrderModel orderModel =
                            HomeOrderCubit.get(context).orderList[itemPos];
                        return OrderItem(
                          orderModel: orderModel,
                        );
                      },
                      itemCount: HomeOrderCubit.get(context).orderList.length,
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
                    titleKey: AppLocalizations.of(context)!.lblNoOrders,
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
