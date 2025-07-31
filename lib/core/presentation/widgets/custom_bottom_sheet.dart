import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

void showBottomModalSheet(
    {required BuildContext context,
    required List<Widget> children,
    EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: AppConstants.padding16),
    TextStyle? textStyle,
    Color bgColor = AppConstants.lightWhiteColor}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppConstants.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppConstants.borderRadius24),
      topRight: Radius.circular(AppConstants.borderRadius24),
    )),
    builder: (BuildContext builder) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.borderRadius24),
            topRight: Radius.circular(AppConstants.borderRadius24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: children,
          ),
        ),
      );
    },
  );
}
