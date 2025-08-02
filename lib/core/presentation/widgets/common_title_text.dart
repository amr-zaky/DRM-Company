import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CommonTitleText extends StatelessWidget {
  const CommonTitleText(
      {Key? key,
      required this.textKey,
      this.textColor = AppConstants.lightBlackColor,
      this.textWeight = FontWeight.normal,
      this.textFontSize = AppConstants.fontSize16,
      this.minTextFontSize = 9,
      this.textAlignment = TextAlign.start,
      this.lines = 1,
      this.textHeight = 0,
      this.textOverflow = TextOverflow.visible,
      this.textDecoration})
      : super(key: key);
  final String textKey;
  final Color textColor;
  final FontWeight textWeight;
  final double textFontSize;
  final double minTextFontSize;
  final TextAlign textAlignment;
  final int lines;
  final double? textHeight;
  final TextOverflow textOverflow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textKey,
      overflow: TextOverflow.ellipsis,
      minFontSize: minTextFontSize,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: textColor,
            fontSize: textFontSize,
            fontWeight: textWeight,
            overflow: textOverflow,
            decoration: textDecoration,
            height: textHeight,
          ),
      textAlign: textAlignment,
      maxLines: lines,
    );
  }
}
