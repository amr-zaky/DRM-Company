import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_global_button.dart';
import '../common_title_text.dart';

Future<void> showAlertDialogOneButton({
  required BuildContext context,
  required String imagePath,
  required double imageWidth,
  required double imageHeight,
  required String title,
  required String description,
  required String buttonText,
  required Function(BuildContext context) onTap,
  required Color titleTextColor,
  bool barrierDismissible = true,
}) async {
  return showDialog(
      barrierColor: AppConstants.lightBlackColor.withOpacity(0.33),
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        return PopScope(
          canPop: false,
          child: Dialog(
            alignment: Alignment.center,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius4),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              width: getWidgetWidth(500),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                CommonAssetSvgImageWidget(
                  imageString: imagePath,
                  height: imageHeight,
                  width: imageWidth,
                ),

                /// Space
                getSpaceHeight(16),

                /// Title
                CommonTitleText(
                  textKey: title,
                  textColor: titleTextColor,
                  textWeight: FontWeight.w500,
                  minTextFontSize: AppConstants.fontSize16,
                  textAlignment: TextAlign.center,
                ),

                CommonTitleText(
                  textKey: description,
                  textColor: AppConstants.mainTextColor,
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.fontSize12,
                  minTextFontSize: AppConstants.fontSize12,
                  textAlignment: TextAlign.center,
                ),

                /// Space
                getSpaceHeight(16),

                CommonGlobalButton(
                  buttonText: buttonText,
                  onPressedFunction: () {
                    onTap(ctx);
                  },
                  height: 36,
                  width: 115,
                  buttonBackgroundColor: AppConstants.lightWhiteColor,
                  showBorder: true,
                  borderColor: AppConstants.lightRedColor,
                  buttonTextColor: AppConstants.lightRedColor,
                ),
              ]),
            ),
          ),
        );
      });
}
