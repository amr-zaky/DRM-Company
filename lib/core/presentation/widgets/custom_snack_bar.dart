import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'common_title_text.dart';

void showSnackBar(
    {required BuildContext context,
    required String title,
    Color? color,
    double? height = 150}) {
  final Color backgroundColor = color ?? AppConstants.mainColor;

  final SnackBar snackBar = SnackBar(
    content: CommonTitleText(
      textKey: title,
      textColor: AppConstants.lightWhiteColor,
      textWeight: FontWeight.w700,
      lines: 2,
      textFontSize: AppConstants.fontSize14,
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - height!,
      right: getWidgetWidth(16),
      left: getWidgetWidth(16),
    ),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
