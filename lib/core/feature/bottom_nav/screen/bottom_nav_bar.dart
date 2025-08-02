import 'package:base_project_repo/features/order_feature/presentation/screen/offer_screen.dart';
import 'package:base_project_repo/features/order_feature/presentation/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/helpers/shared_texts.dart';
import '/features/home_feature/presentation/home_page.dart';
import '/features/setting_feature/presentation/Screen/setting_screen.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/keys/icon_path.dart';
import '../../../helpers/shared.dart';
import '../../../presentation/widgets/Alert_Dialogs/guest_mode_dialog.dart';
import '../logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/Bottom_Nav_Cubit/bottom_nav_cubit_state.dart';
import 'widget/bottom_nav_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    /// Pages
    final List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      OfferListScreen(),
      const OrderListScreen(),
      const SettingScreen(),
    ];

    return BlocConsumer<BottomNavCubit, BottomNavCubitState>(
      listener:
          (BuildContext bottomNavCtx, BottomNavCubitState bottomNavState) {},
      builder: (BuildContext bottomNavCtx, BottomNavCubitState bottomNavState) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
                bottom: 30,
                left: AppConstants.padding24,
                right: AppConstants.padding24),
            child: Container(
                width: getWidgetWidth(250),
                height: getWidgetHeight(65),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppConstants.lightBlackColor.withOpacity(0.12),
                        blurRadius: 4)
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppConstants.borderRadius32),
                  ),
                  color: AppConstants.lightWhiteColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () =>
                          bottomNavCtx.read<BottomNavCubit>().selectItem(0),
                      child: BottomNavItem(
                        isSelected: bottomNavCtx
                            .read<BottomNavCubit>()
                            .isItemSelected(0),
                        image: IconPath.homeUnActiveIcon,
                        selectedImage: IconPath.homeActiveIcon,
                        title: AppLocalizations.of(context)!.lblHome,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          bottomNavCtx.read<BottomNavCubit>().selectItem(1),
                      child: BottomNavItem(
                        isSelected: bottomNavCtx
                            .read<BottomNavCubit>()
                            .isItemSelected(1),
                        image: IconPath.offersUnActiveIcon,
                        selectedImage: IconPath.offersActiveIcon,
                        title: AppLocalizations.of(context)!.lblMyOffers,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (SharedText.isGuestMode) {
                          showGuestModeAlertDialog(context);
                        } else {
                          bottomNavCtx.read<BottomNavCubit>().selectItem(2);
                        }
                      },
                      child: BottomNavItem(
                        isSelected: bottomNavCtx
                            .read<BottomNavCubit>()
                            .isItemSelected(2),
                        image: IconPath.orderIcon,
                        selectedImage: IconPath.orderActiveIcon,
                        title: AppLocalizations.of(context)!.lblOrder,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          bottomNavCtx.read<BottomNavCubit>().selectItem(3),
                      child: BottomNavItem(
                        isSelected: bottomNavCtx
                            .read<BottomNavCubit>()
                            .isItemSelected(3),
                        image: IconPath.settingIcon,
                        selectedImage: IconPath.settingActiveIcon,
                        title: AppLocalizations.of(context)!.lblSetting,
                      ),
                    ),
                  ],
                )),
          ),
          body: PopScope(
            canPop: bottomNavCtx.read<BottomNavCubit>().selectedIndex == 0,
            onPopInvoked: (bool didPop) {
              if (didPop) {
                return;
              }
              if (bottomNavCtx.read<BottomNavCubit>().selectedIndex != 0) {
                bottomNavCtx.read<BottomNavCubit>().selectItem(0);
              }
            },
            child: Center(
              child: widgetOptions
                  .elementAt(bottomNavCtx.read<BottomNavCubit>().selectedIndex),
            ),
          ),
        );
      },
    );
  }
}
