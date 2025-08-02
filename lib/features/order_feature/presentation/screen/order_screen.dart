import 'package:base_project_repo/core/constants/enums/exception_enums.dart';
import 'package:base_project_repo/core/constants/enums/order_type.dart';
import 'package:base_project_repo/core/presentation/widgets/CommonTabWidget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/orders_cubit/orders_states.dart';
import 'package:base_project_repo/features/order_feature/presentation/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_asset_image_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/features/order_feature/presentation/logic/orders_cubit/order_cubit.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderCubit orderCubit;

  @override
  void initState() {
    super.initState();
    orderCubit = OrderCubit.get(context);
    orderCubit.getOrderList();
    orderCubit.scrollController = ScrollController();
    orderCubit.scrollController.addListener(
      () {
        orderCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblMyOrders,
        withBack: false,
        centerTitle: false,
        leadingWidth: AppConstants.padding24,
      ),
      body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (BuildContext orderCtx, OrderStates orderState) {
        if (orderState is OrderErrorState) {
          checkUserAuth(context: orderCtx, errorType: orderState.error!.type);
          showSnackBar(
              context: orderCtx,
              title: orderState.error!.type.getErrorMessage(context) ??
                  orderState.error!.errorMassage);
        }
      }, builder: (BuildContext orderCtx, OrderStates orderState) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.padding16)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    CommonTabWidget(
                      onTab: () {
                        orderCubit.updateOrderType(OrderType.newOrders);
                        orderCubit.getOrderList();
                      },
                      isActive: orderCubit.orderType == OrderType.newOrders,
                      title: AppLocalizations.of(context)!.lblCurrentOrder,
                      borderRadius: SharedText.currentLocale == "ar"
                          ? const BorderRadius.only(
                              topRight:
                                  Radius.circular(AppConstants.borderRadius40),
                              bottomRight:
                                  Radius.circular(AppConstants.borderRadius40),
                            )
                          : const BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.borderRadius40),
                              bottomLeft:
                                  Radius.circular(AppConstants.borderRadius40),
                            ),
                    ),
                    CommonTabWidget(
                      onTab: () {
                        orderCubit.updateOrderType(OrderType.oldOrders);
                        orderCubit.getOrderList();
                      },
                      isActive: orderCubit.orderType == OrderType.oldOrders,
                      title: AppLocalizations.of(context)!.lblOld,
                      borderRadius: SharedText.currentLocale == "ar"
                          ? const BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.borderRadius40),
                              bottomLeft:
                                  Radius.circular(AppConstants.borderRadius40),
                            )
                          : const BorderRadius.only(
                              topRight:
                                  Radius.circular(AppConstants.borderRadius40),
                              bottomRight:
                                  Radius.circular(AppConstants.borderRadius40),
                            ),
                    ),
                  ],
                ),
                if (orderState is OrderLoadingState) ...<Widget>[
                  const Expanded(child: CommonLoadingWidget())
                ] else if (orderState is OrderErrorState) ...<Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CommonError(
                          errorType: orderState.error!.type,
                          withButton: true,
                          onTap: () => orderCubit.getOrderList(),
                        ),
                      ],
                    ),
                  )
                ] else if (orderState is OrderEmptyState ||
                    orderCubit.orderList.isEmpty) ...<Widget>[
                  getSpaceHeight(AppConstants.padding36),
                  EmptyScreen(
                    imageString: IconPath.emptyIcon,
                    imageHeight: 200,
                    imageWidth: 110,
                    titleKey: AppLocalizations.of(context)!.lblNoData,
                    description:
                        AppLocalizations.of(context)!.lblNoOrdersDescription,
                  )
                ] else ...<Widget>[
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: getWidgetHeight(AppConstants.padding16),
                          horizontal: getWidgetWidth(
                            AppConstants.padding4,
                          )),
                      shrinkWrap: true,
                      controller: orderCubit.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: orderCubit.orderList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return getSpaceHeight(AppConstants.padding16);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            OrderItem(
                              orderModel: orderCubit.orderList[index],
                            ),
                            if (index >= orderCubit.orderList.length &&
                                orderCubit.hasMoreData)
                              const CommonLoadingWidget()
                            else
                              const SizedBox()
                          ],
                        );
                      },
                    ),
                  )
                ]
              ]),
        );
      }),
    );
  }
}
