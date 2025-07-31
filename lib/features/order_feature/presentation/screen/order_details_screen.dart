import 'package:base_project_repo/core/constants/enums/order_status.dart';
import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';
import 'package:base_project_repo/core/helpers/extensions/format_date_time_to_time_only.dart';
import 'package:base_project_repo/core/model/address_model.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/Alert_Dialogs/alert_dialog_with_one_button.dart';
import 'package:base_project_repo/core/presentation/widgets/Alert_Dialogs/alert_dialog_with_two_buttons.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_drop_down_menu.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:base_project_repo/core/presentation/widgets/common_waiting_dialog_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_snack_bar.dart';
import 'package:base_project_repo/core/presentation/widgets/form_input_widgets/date_form_widget.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/create_order_cubit/create_order_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/create_order_cubit/create_order_states.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/orders_cubit/order_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/update_order_cubit/update_order_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/update_order_cubit/update_orders_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_cached_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class OrdersDetailsScreen extends StatefulWidget {
  const OrdersDetailsScreen({
    super.key,
    required this.routeArgument,
  });

  final RouteArgument routeArgument;

  @override
  State<OrdersDetailsScreen> createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        leadingWidth: getWidgetWidth(AppConstants.padding16),
        customTitleWidget: CommonTitleText(
          textKey: widget.routeArgument.orderModel?.productModel.name ?? "---",
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
        child: BlocConsumer<UpdateOrderCubit, UpdateOrderStates>(
          listener: (BuildContext context, UpdateOrderStates state) {
            if (state is UpdateOrderLoadingState) {
              showWaitingDialog(context);
            } else if (state is UpdateOrderErrorState) {
              context.pop();
              checkUserAuth(context: context, errorType: state.error!.type);
              showAlertDialogOneButton(
                context: context,
                imagePath: IconPath.wrongIcon,
                imageWidth: 48,
                imageHeight: 48,
                title: AppLocalizations.of(context)!.lblWrongHappen,
                description: state.error!.errorMassage,
                buttonText: AppLocalizations.of(context)!.lblBack,
                onTap: (BuildContext ctx) {
                  ctx.pop();
                },
                titleTextColor: AppConstants.lightRedColor,
                barrierDismissible: false,
              );
            } else if (state is UpdateOrderSuccessState) {
              context.pop();
              context.pop();
              OrderCubit.get(context).getOrderList();
            }
          },
          builder: (BuildContext context, UpdateOrderStates state) {
            if (widget.routeArgument.orderModel!.status == "new") {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16,
                    vertical: AppConstants.padding16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CommonGlobalButton(
                        height: 32,
                        buttonText:
                            AppLocalizations.of(context)!.lblCancelMyOrder,
                        buttonBackgroundColor: AppConstants.transparent,
                        borderColor: AppConstants.lightRedColor,
                        buttonTextColor: AppConstants.lightRedColor,
                        showBorder: true,
                        onPressedFunction: () {
                          UpdateOrderCubit.get(context).updateServices(
                              widget.routeArgument.orderModel!,
                              OrderStatus.cancelledbyclient);
                        },
                      )
                    ],
                  ));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.padding16,
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.padding8),
                ),
                color: AppConstants.mainTextColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppConstants.shadowColor,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblOrderStatus,
                      textColor: AppConstants.lightWhiteColor,
                    ),
                    CommonTitleText(
                      textKey: widget.routeArgument.orderModel?.status ?? "---",
                      textColor: AppConstants.lightWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
            getSpaceHeight(AppConstants.padding16),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(context)!.lblOrderDetails,
                          textColor: AppConstants.greenColor,
                          textWeight: FontWeight.w500,
                        )
                      ],
                    ),
                    getSpaceHeight(AppConstants.padding8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonTitleText(
                          textKey: widget.routeArgument.orderModel?.productModel
                                  .name ??
                              "---",
                          textFontSize: AppConstants.fontSize14,
                          textWeight: FontWeight.w500,
                        ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblQuantity,
                                textWeight: FontWeight.w700,
                                textFontSize: AppConstants.fontSize12,
                                textColor: AppConstants.greenColor,
                              ),
                              CommonTitleText(
                                textKey: widget
                                    .routeArgument.orderModel!.quantity
                                    .toString(),
                                textWeight: FontWeight.w700,
                                textColor: AppConstants.mainColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblTotal,
                          textWeight: FontWeight.w700,
                        ),
                        Row(
                          children: <Widget>[
                            CommonTitleText(
                              textKey: widget.routeArgument.orderModel!.total
                                  .toString(),
                              textWeight: FontWeight.w700,
                            ),
                            CommonTitleText(
                              textKey:
                                  "  ${AppLocalizations.of(context)!.lblCurrency}",
                              textWeight: FontWeight.w700,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            getSpaceHeight(AppConstants.padding8),
            const Divider(
              thickness: 0.5,
            ),
            getSpaceHeight(AppConstants.padding8),
            Row(
              children: <Widget>[
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblOrderDate,
                  textColor: AppConstants.greenColor,
                  textWeight: FontWeight.w500,
                )
              ],
            ),
            getSpaceHeight(AppConstants.padding16),
            Row(
              children: <Widget>[
                const CommonAssetSvgImageWidget(
                    imageString: IconPath.calenderIcon, height: 16, width: 16),
                getSpaceWidth(AppConstants.padding8),
                CommonTitleText(
                  textKey: DateTime.parse(widget.routeArgument.orderModel!.date)
                      .formatDateTimeToShowDayName(),
                  textColor: AppConstants.lightGrayOffColor,
                  textFontSize: AppConstants.fontSize12,
                ),
              ],
            ),
            getSpaceHeight(AppConstants.padding8),
            const Divider(
              thickness: 0.5,
            ),
            getSpaceHeight(AppConstants.padding8),
            Row(
              children: <Widget>[
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblOrderAddress,
                  textColor: AppConstants.greenColor,
                  textWeight: FontWeight.w500,
                )
              ],
            ),
            getSpaceHeight(AppConstants.padding16),
            Row(
              children: <Widget>[
                const CommonAssetSvgImageWidget(
                  imageString: IconPath.locationIcon,
                  height: 16,
                  width: 16,
                ),
                getSpaceWidth(AppConstants.padding8),
                CommonTitleText(
                  textKey: widget.routeArgument.orderModel!.addressModel.name ??
                      "---",
                  textColor: AppConstants.lightGrayOffColor,
                  textFontSize: AppConstants.fontSize12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
