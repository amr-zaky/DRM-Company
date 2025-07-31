import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/Alert_Dialogs/guest_mode_dialog.dart';
import '/core/presentation/widgets/common_title_text.dart';

class SectionContentItem extends StatelessWidget {
  const SectionContentItem({
    Key? key,
    required this.title,
    this.isLastItem = false,
    this.actionWidget,
    this.screenName,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String? screenName;
  final Widget? actionWidget;
  final bool? isLastItem;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            if (SharedText.isGuestMode) {
              showGuestModeAlertDialog(context);
            } else if (screenName != null) {
              context.pushNamed(screenName!);
            }
          },
      child: Column(
        children: <Widget>[
          getSpaceHeight(AppConstants.padding4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ///my account
              CommonTitleText(
                textKey: title,
                textWeight: FontWeight.w500,
                textFontSize: AppConstants.fontSize12,
                textColor: AppConstants.mainTextColor,
                textHeight: 0,
              ),
              Transform.scale(
                scaleX: SharedText.currentLocale == "en" ? -1 : -1,
                child: actionWidget ??
                    const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppConstants.greyColor,
                      size: 22,
                    ),
              ),
            ],
          ),
          getSpaceHeight(4),
          if (!isLastItem!) ...<Widget>[
            const Divider(
              color: AppConstants.greyColor,
              thickness: 0.2,
            )
          ]
        ],
      ),
    );
  }
}
