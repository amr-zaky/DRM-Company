import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_constants.dart';
import '../../constants/keys/icon_path.dart';
import '../../helpers/shared.dart';
import '../../helpers/shared_texts.dart';
import '../routes/route_names.dart';
import 'Alert_Dialogs/guest_mode_dialog.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_title_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {Key? key,
      this.onBackPressed,
      this.withBack = true,
      this.customTitleWidget,
      this.withNotification = false,
      this.centerTitle = true,
      this.pageTitle = '',
      this.leadingWidget,
      this.elevation = 0,
      this.leadingWidth,
      this.customActionWidget,
      this.backGroundColor = AppConstants.lightWhiteColor})
      : super(key: key);
  final bool withBack;
  final bool withNotification;
  final bool centerTitle;
  final Widget? customActionWidget;
  final Widget? customTitleWidget;
  final Widget? leadingWidget;
  final String pageTitle;
  final double elevation;
  final double? leadingWidth;
  final Color? backGroundColor;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backGroundColor,
        elevation: elevation,
        centerTitle: centerTitle,
        automaticallyImplyLeading: withBack,
        titleSpacing: 0,
        leadingWidth: withBack ? getWidgetWidth(40) : leadingWidth,
        leading: withBack
            ? FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: AppConstants.padding16),
                    GestureDetector(
                      onTap: onBackPressed ?? () => context.pop(),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.padding4,
                              vertical: AppConstants.padding4),
                          child: RotatedBox(
                            quarterTurns:
                                SharedText.currentLocale == "ar" ? 0 : 2,
                            child: const CommonAssetSvgImageWidget(
                                imageString: IconPath.rightArrowIcon,
                                height: 40,
                                imageColor: AppConstants.lightBlackColor,
                                width: 40),
                          )),
                    ),
                  ],
                ),
              )
            : leadingWidget != null
                ? Row(
                    children: <Widget>[
                      getSpaceWidth(AppConstants.padding16),
                      leadingWidget ?? const SizedBox()
                    ],
                  )
                : const SizedBox(),
        title: customTitleWidget ??
            CommonTitleText(
              textKey: pageTitle,
              textColor: AppConstants.mainTextColor,
              textWeight: FontWeight.w500,
            ),
        actions: <Widget>[
          if (withNotification)
            GestureDetector(
              onTap: () {
                if (SharedText.isGuestMode) {
                  showGuestModeAlertDialog(context);
                } else {
                  context.pushNamed(RouteNames.notificationPageRoute);
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: CommonAssetSvgImageWidget(
                    imageString: IconPath.notificationIcon,
                    height: 40,
                    imageColor: AppConstants.mainColor,
                    width: 40),
              ),
            ),
          customActionWidget ?? const SizedBox(),
          const SizedBox(width: AppConstants.padding16),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Size get bottomSize => const Size.fromHeight(kToolbarHeight + 14);

  Size get emptyBottomSize => const Size.fromHeight(0);
}
