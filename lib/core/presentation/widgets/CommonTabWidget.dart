import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_title_text.dart';

class CommonTabWidget extends StatelessWidget {
  final Function() onTab;
  final bool isActive;
  final String title;
  final BorderRadius borderRadius;

  const CommonTabWidget(
      {super.key,
      required this.onTab,
      required this.isActive,
      required this.title, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTab,
        child: Container(
          height: getWidgetHeight(32),
          decoration: BoxDecoration(
              color: isActive
                  ? AppConstants.mainTextColor
                  : AppConstants.greyTextColor,
              borderRadius: borderRadius),
          child: Center(
              child: CommonTitleText(
            textKey: title,
            textWeight: FontWeight.w500,
            textFontSize: AppConstants.fontSize14,
            minTextFontSize: AppConstants.fontSize14,
            textColor: isActive
                ? AppConstants.lightWhiteColor
                : AppConstants.mainTextColor,
          )),
        ),
      ),
    );
  }
}
