import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_constants.dart';
import '../../constants/keys/icon_path.dart';
import 'common_asset_svg_image_widget.dart';

Future<dynamic> showWaitingDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    // barrierColor: AppConstants.lightRedColor,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: AppConstants.transparent,
          elevation: 0.0,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Lottie.asset('assets/images/loader.json'),
          ));
    },
  );
}
