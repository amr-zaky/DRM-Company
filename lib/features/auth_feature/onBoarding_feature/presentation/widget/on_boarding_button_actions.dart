import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';

class OnBoardingButtonAction extends StatefulWidget {
  const OnBoardingButtonAction({super.key});

  @override
  State<OnBoardingButtonAction> createState() => _OnBoardingButtonActionState();
}

class _OnBoardingButtonActionState extends State<OnBoardingButtonAction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommonGlobalButton(
            buttonText: AppLocalizations.of(context)!.lblCreateAccount,
            buttonBackgroundColor: AppConstants.appBarTitleColor,
            onPressedFunction: () {
              context.pushNamed(RouteNames.singUpPageRoute);
            }),
        getSpaceHeight(AppConstants.padding16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                context.pushNamed(RouteNames.loginHomePageRoute);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblAlreadyUser,
                    textColor: AppConstants.lightGrayOffColor,
                    textFontSize: AppConstants.fontSize14,
                  ),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblSignIn,
                    textColor: AppConstants.mainColor,
                    textFontSize: AppConstants.fontSize14,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
