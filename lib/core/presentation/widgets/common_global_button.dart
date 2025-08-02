import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'common_title_text.dart';

class CommonGlobalButton extends StatelessWidget {
  const CommonGlobalButton(
      {Key? key,
      required this.buttonText,
      required this.onPressedFunction,
      this.buttonBackgroundColor,
      this.onPressedColor,
      this.shadowBackgroundColor,
      this.elevation = 0.0,
      this.width = 343,
      this.height = 40,
      this.iconColor = AppConstants.lightWhiteColor,
      this.buttonTextColor = AppConstants.lightWhiteColor,
      this.buttonTextFontWeight = FontWeight.normal,
      this.buttonTextSize = 14,
      this.icon,
      this.radius = AppConstants.borderRadius8,
      this.spaceSize = 8.0,
      this.boarderWidth = 1.0,
      this.isLoading = false,
      this.isEnable = true,
      this.showBorder = false,
      this.borderColor = AppConstants.mainColor})
      : super(key: key);
  final String buttonText;
  final Function() onPressedFunction;
  final Color? buttonBackgroundColor;
  final Color? onPressedColor;
  final Color? shadowBackgroundColor;
  final double? elevation;
  final double? width;
  final double? height;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextFontWeight;
  final Color? iconColor;
  final double? radius;
  final Widget? icon;
  final double? spaceSize;
  final double? boarderWidth;
  final bool isLoading;
  final bool isEnable;
  final bool showBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = getWidgetWidth(width!);
    final double buttonHeight = getWidgetHeight(height!);

    return ElevatedButton(
      onPressed: isLoading || !isEnable ? null : onPressedFunction,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation!),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: showBorder
                ? isLoading || !isEnable
                    ? AppConstants.shadowColor
                    : borderColor!
                : AppConstants.transparent,
            width: boarderWidth ?? 1,
          ),
        ),
        shadowColor: MaterialStateProperty.all(
          shadowBackgroundColor ?? AppConstants.greyColor.withOpacity(.3),
        ),
        overlayColor: MaterialStateProperty.all(
          onPressedColor ?? AppConstants.greyColor.withOpacity(.25),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        fixedSize:
            MaterialStateProperty.all<Size>(Size(buttonWidth, buttonHeight)),
        backgroundColor: isLoading || !isEnable
            ? MaterialStateProperty.all(AppConstants.shadowColor)
            : MaterialStateProperty.all(
                buttonBackgroundColor ?? AppConstants.mainColor),
      ),
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonTitleText(
                  textKey: isLoading
                      ? AppLocalizations.of(context)!.lblLoading
                      : buttonText,
                  textColor: isEnable
                      ? isLoading
                          ? AppConstants.greyColor
                          : buttonTextColor!
                      : AppConstants.greyColor,
                  textFontSize: buttonTextSize!,
                  textWeight: buttonTextFontWeight!,
                ),
                getSpaceWidth(spaceSize!),
                if (!isLoading) icon!,
              ],
            )
          : CommonTitleText(
              textKey: isLoading
                  ? AppLocalizations.of(context)!.lblLoading
                  : buttonText,
              textColor: isEnable
                  ? isLoading
                      ? AppConstants.greyColor
                      : buttonTextColor!
                  : AppConstants.greyColor,
              textFontSize: buttonTextSize!,
              textWeight: buttonTextFontWeight!,
            ),
    );
  }
}
