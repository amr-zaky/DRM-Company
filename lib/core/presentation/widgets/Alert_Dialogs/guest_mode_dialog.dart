import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/keys/icon_path.dart';
import '../../routes/route_names.dart';
import 'alert_dialog_with_two_buttons.dart';

void showGuestModeAlertDialog(BuildContext context) {
  showAlertDialogWithTwoButton(
    context: context,
    title: AppLocalizations.of(context)!.lblLoginPls,
    description: AppLocalizations.of(context)!.lblToFullTry,
    firstButtonText: AppLocalizations.of(context)!.lblLogin,
    secondButtonText: AppLocalizations.of(context)!.lblNewUser,
    firstButtonOnTap: (BuildContext ctx) {
      ctx.pop();

      context.pushNamed(RouteNames.loginHomePageRoute);
    },
    secondButtonOnTap: (BuildContext ctx) {
      ctx.pop();

      context.pushNamed(RouteNames.singUpPageRoute);
    },
    titleTextColor: AppConstants.successColor,
    firstButtonTextColor: AppConstants.lightWhiteColor,
    firstButtonColor: AppConstants.mainColor,
    firstButtonBorderColor: AppConstants.mainColor,
    imagePath: IconPath.logOutImage,
    imageWidth: 49,
    imageHeight: 88,
  );
}
