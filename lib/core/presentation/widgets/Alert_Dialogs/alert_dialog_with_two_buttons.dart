import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_global_button.dart';
import '../common_title_text.dart';

Future<void> showAlertDialogWithTwoButton({
  required BuildContext context,
  String? imagePath,
  double imageWidth = 90.0,
  double imageHeight = 90.0,
  required String title,
  required String description,
  required String firstButtonText,
  required String secondButtonText,
  required Function(BuildContext ctx) firstButtonOnTap,
  required Function(BuildContext ctx) secondButtonOnTap,
  required Color titleTextColor,
  bool showImage = true,
  bool isFirstButtonLoading = false,
  double firstButtonRadius = AppConstants.borderRadius8,
  Color firstButtonColor = AppConstants.lightWhiteColor,
  Color firstButtonBorderColor = AppConstants.lightRedColor,
  Color firstButtonTextColor = AppConstants.lightRedColor,
  Color secondButtonTextColor = AppConstants.mainColor,
  bool canGoBack = true,
}) async {
  return showDialog(
      barrierColor: AppConstants.lightBlackColor.withOpacity(0.33),
      context: context,

      builder: (BuildContext contextDialog) {
        return PopScope(
          canPop: canGoBack,
          child: Dialog(
            alignment: Alignment.center,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius4),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.padding24,
                horizontal: AppConstants.padding8,
              ),
              width: getWidgetWidth(500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (showImage) ...<Widget>[
                    CommonAssetSvgImageWidget(
                      imageString: imagePath!,
                      height: imageHeight,
                      width: imageWidth,
                    ),

                    /// Space
                    getSpaceHeight(16),
                  ],

                  /// Title
                  CommonTitleText(
                    textKey: title,
                    textColor: titleTextColor,
                    textWeight: FontWeight.w500,
                    minTextFontSize: AppConstants.fontSize16,
                    textHeight: 0,
                  ),

                  /// Space
                  getSpaceHeight(4),

                  CommonTitleText(
                    textKey: description,
                    textColor: AppConstants.borderInputColor,
                    textWeight: FontWeight.w500,
                    textFontSize: AppConstants.fontSize12,
                    minTextFontSize: AppConstants.fontSize12,
                  ),

                  /// Space
                  getSpaceHeight(16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Cancel
                      CommonGlobalButton(
                        showBorder: true,
                        borderColor: firstButtonBorderColor,
                        width: 112,
                        buttonTextColor: firstButtonTextColor,
                        buttonBackgroundColor: firstButtonColor,
                        buttonText: firstButtonText,
                        onPressedFunction: () {
                          firstButtonOnTap(contextDialog);
                        },
                        height: 32,
                        radius: firstButtonRadius,
                        isLoading: isFirstButtonLoading,
                        isEnable: !isFirstButtonLoading,
                      ),
                      getSpaceWidth(16),

                      /// Confirm
                      CommonGlobalButton(
                        showBorder: true,
                        borderColor: AppConstants.lightWhiteColor,
                        width: 112,
                        buttonBackgroundColor: AppConstants.lightWhiteColor,
                        buttonTextColor: secondButtonTextColor,
                        buttonText: secondButtonText,
                        onPressedFunction: () {
                          secondButtonOnTap(contextDialog);
                        },
                        height: 32,
                        isLoading: isFirstButtonLoading,
                        isEnable: !isFirstButtonLoading,
                        radius: AppConstants.borderRadius24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
