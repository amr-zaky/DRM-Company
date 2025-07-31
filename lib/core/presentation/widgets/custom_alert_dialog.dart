import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';

Future<void> showAlertDialog(
    BuildContext context, List<Widget> children) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: getWidgetWidth(500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      });
}
