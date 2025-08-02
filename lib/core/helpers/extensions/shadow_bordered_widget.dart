import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

extension ShadowBorderedWidget on BoxDecoration {
  BoxDecoration appBarBackArrow() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: AppConstants.backBGColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppConstants.lightBlackColor.withOpacity(0.1),
            blurRadius: 8),
      ],
    );
  }

  BoxDecoration commonDecorationShadow(
      {Color? fillColor,
      double opacity = 0.08,
      double radius = AppConstants.borderRadius8}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: fillColor ?? AppConstants.lightWhiteColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppConstants.lightBlackColor.withOpacity(opacity),
            blurRadius: 4),
      ],
    );
  }
}
