import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer(
      {Key? key,
      this.radius = AppConstants.padding8,
      this.height = 78,
      this.width = 237})
      : super(key: key);
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: Image.asset(
        'assets/images/loading.gif',
        height: getWidgetHeight(height!),
        width: getWidgetWidth(width!),
        fit: BoxFit.fill,
      ),
    );
  }
}
