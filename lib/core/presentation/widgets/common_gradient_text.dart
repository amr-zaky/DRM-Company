import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CommonGradientText extends StatelessWidget {
  const CommonGradientText({
    super.key,
    required this.textKey,
    required this.textColors,
    this.textWeight = FontWeight.normal,
    this.textFontSize = AppConstants.fontSize16,
    this.minTextFontSize = 9,
    this.textAlignment = TextAlign.start,
    this.lines = 1,
    this.textOverflow = TextOverflow.visible,
    this.textDecoration,
  });
  final String textKey;
  final List<Color> textColors;
  final FontWeight textWeight;
  final double textFontSize;
  final double minTextFontSize;
  final TextAlign textAlignment;
  final int lines;
  final TextOverflow textOverflow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) =>
          LinearGradient(colors: textColors).createShader(
        Rect.fromLTWH(
          0,
          -1,
          bounds.width,
          bounds.height,
        ),
      ),
      child: AutoSizeText(
        textKey,
        overflow: TextOverflow.ellipsis,
        minFontSize: minTextFontSize,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: textFontSize,
              fontWeight: textWeight,
              overflow: textOverflow,
              decoration: textDecoration,
            ),
        textAlign: textAlignment,
        maxLines: lines,
      ),
    );
  }
}
