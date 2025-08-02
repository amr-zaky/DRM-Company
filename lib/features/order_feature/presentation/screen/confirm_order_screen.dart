import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/bottom_nav/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';
import 'package:base_project_repo/core/model/address_model.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_cached_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class ConfirmOrdersScreen extends StatefulWidget {
  const ConfirmOrdersScreen({
    super.key,
  });

  @override
  State<ConfirmOrdersScreen> createState() => _ConfirmOrdersScreenState();
}

class _ConfirmOrdersScreenState extends State<ConfirmOrdersScreen> {
  late CreateOrderCubit createOrderCubit;

  @override
  void initState() {
    super.initState();
    createOrderCubit = CreateOrderCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        leadingWidth: getWidgetWidth(AppConstants.padding16),
        customTitleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblOrderService,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CommonGlobalButton(
                      height: 32,
                      buttonText: AppLocalizations.of(context)!.lblOrderNow,
                      buttonBackgroundColor: AppConstants.greenColor,
                      onPressedFunction: () {
                        if (createOrderCubit.dateTime == null) {
                          showSnackBar(
                            context: context,
                            title: AppLocalizations.of(context)!
                                .lblYouMustPickADate,
                          );
                          return;
                        } else if (createOrderCubit.selectedAddress == null) {
                          showSnackBar(
                            context: context,
                            title: AppLocalizations.of(context)!
                                .lblYouMustPickALocation,
                          );
                          return;
                        }
                        createOrderCubit.createOrder();
                      },
                    )
                  ],
                ));
          },
        ),
      ),
      body: BlocConsumer<CreateOrderCubit, OrderStates>(
        listener: (BuildContext context, OrderStates state) {
          if (state is CreateOrderLoadingState) {
            showWaitingDialog(context);
          } else if (state is CreateOrderFailState) {
            context.pop();
            checkUserAuth(context: context, errorType: state.error.type);
            showAlertDialogOneButton(
              context: context,
              imagePath: IconPath.wrongIcon,
              imageWidth: 48,
              imageHeight: 48,
              title: AppLocalizations.of(context)!.lblWrongHappen,
              description: state.error.errorMassage,
              buttonText: AppLocalizations.of(context)!.lblBack,
              onTap: (ctx) {
                ctx.pop();
              },
              titleTextColor: AppConstants.lightRedColor,
              barrierDismissible: false,
            );
          } else if (state is CreateOrderSuccessState) {
            context.pop();
            showAlertDialogWithTwoButton(
              context: context,
              imagePath: IconPath.successIcon,
              imageWidth: 48,
              imageHeight: 48,
              title: AppLocalizations.of(context)!.lblYourOrderSend,
              description: AppLocalizations.of(context)!.lblThxFromDrm,
              titleTextColor: AppConstants.mainTextColor,
              firstButtonBorderColor: AppConstants.mainTextColor,
              firstButtonColor: AppConstants.mainTextColor,
              firstButtonTextColor: AppConstants.lightWhiteColor,
              firstButtonText: AppLocalizations.of(context)!.lblOrder,
              secondButtonText: AppLocalizations.of(context)!.lblHome,
              firstButtonOnTap: (BuildContext ctx) {
                BottomNavCubit.get(context).selectItem(1);

                context.go(RouteNames.mainBottomNavPageRoute);
              },
              secondButtonOnTap: (BuildContext ctx) {
                context.go(RouteNames.mainBottomNavPageRoute);
              },
              secondButtonTextColor: AppConstants.mainTextColor,
              canGoBack: false,
            );
          }
        },
        builder: (BuildContext context, OrderStates state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding16,
            ),
            child: Column(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
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
                          children: [
                            CommonTitleText(
                              textKey: createOrderCubit.selectedProduct?.name ??
                                  "---",
                              textFontSize: AppConstants.fontSize14,
                              textWeight: FontWeight.w500,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(AppConstants.padding8),
                                  topRight:
                                      Radius.circular(AppConstants.padding8),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    textKey:
                                        createOrderCubit.quantity.toString(),
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
                          ],
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!.lblTotal,
                              textWeight: FontWeight.w700,
                            ),
                            Row(
                              children: [
                                CommonTitleText(
                                  textKey: (createOrderCubit.quantity *
                                          (createOrderCubit
                                                  .selectedProduct?.price ??
                                              0))
                                      .toString(),
                                  textWeight: FontWeight.w700,
                                ),
                                CommonTitleText(
                                  textKey:
                                      " ${AppLocalizations.of(context)!.lblCurrency}",
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
                Divider(
                  thickness: 0.5,
                ),
                getSpaceHeight(AppConstants.padding8),
                Row(
                  children: [
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblOrderDate,
                      textColor: AppConstants.greenColor,
                      textWeight: FontWeight.w500,
                    )
                  ],
                ),
                getSpaceHeight(AppConstants.padding16),
                DateFormWidget(
                  title: AppLocalizations.of(context)!.lblDate,
                  selectedDate: (DateTime dateTime) {
                    createOrderCubit.updateDateTime(dateTime);
                  },
                  dateController: createOrderCubit.dateController,
                  validator: (String? value) {
                    return null;
                  },
                  dateOnChanged: (String? va) {
                    return null;
                  },
                  firstDate: DateTime.now(),
                ),
                getSpaceHeight(AppConstants.padding8),
                Divider(
                  thickness: 0.5,
                ),
                getSpaceHeight(AppConstants.padding8),
                Row(
                  children: [
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblOrderAddress,
                      textColor: AppConstants.greenColor,
                      textWeight: FontWeight.w500,
                    )
                  ],
                ),
                getSpaceHeight(AppConstants.padding16),
                CommonDropdownButton(
                  onChangeValue: (SelectableModel? selectedAddress) {
                    createOrderCubit
                        .updateSelectedAddress(selectedAddress as AddressModel);
                  },
                  listOfItems: HomeAddressCubit.get(context).addressList,
                  selectedValue: createOrderCubit.selectedAddress,
                  hintText: AppLocalizations.of(context)!.lblAddress,
                  dropdownWidth: getWidgetWidth(345),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
