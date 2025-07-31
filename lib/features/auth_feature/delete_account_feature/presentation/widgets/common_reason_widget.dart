import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/extensions/prevent_string_spacing.dart';
import '/core/helpers/shared.dart';
import '/core/model/reason_model.dart';
import '/core/presentation/widgets/common_title_text.dart';

class CommonReasonWidget extends StatelessWidget {
  const CommonReasonWidget(
      {super.key,
      required this.reasonModel,
      required this.isSelected,
      required this.onTap});
  final ReasonModel reasonModel;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(AppConstants.padding8)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            /// Circle
            Container(
              height: getWidgetHeight(16),
              width: getWidgetHeight(16),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppConstants.lightGreyColor),
              ),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppConstants.mainColor
                        : AppConstants.transparent),
              ),
            ),
            getSpaceWidth(8),

            /// Reason
            CommonTitleText(
              textKey: reasonModel.title!.toTitleCase(),
              textColor: AppConstants.borderInputColor,
              minTextFontSize: AppConstants.fontSize12,
              textFontSize: AppConstants.fontSize12,
            ),
          ],
        ),
      ),
    );
  }
}
