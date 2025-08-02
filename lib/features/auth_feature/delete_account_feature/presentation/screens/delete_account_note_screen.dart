import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';

class DeleteAccountNoteScreen extends StatelessWidget {
  const DeleteAccountNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblDeleteAccount,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getWidgetWidth(AppConstants.padding16)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                getSpaceHeight(AppConstants.padding24),
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblDeleteAccountNote,
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.fontSize12,
                  minTextFontSize: AppConstants.fontSize12,
                  textColor: AppConstants.borderInputColor,
                  lines: 5,
                  textHeight: 0,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CommonGlobalButton(
                  buttonText: AppLocalizations.of(context)!.lblDeleteAccount,
                  boarderWidth: .4,
                  radius: AppConstants.borderRadius8,
                  onPressedFunction: () => context.pushNamed(
                      RouteNames.deleteAccountEnterPasswordScreenRoute),
                  buttonTextColor: AppConstants.lightRedColor,
                  buttonBackgroundColor: AppConstants.transparent,
                  borderColor: AppConstants.lightRedColor,
                  showBorder: true,
                ),
                getSpaceHeight(SharedText.screenHeight * 0.4)
              ],
            )
          ],
        ),
      ),
    );
  }
}
