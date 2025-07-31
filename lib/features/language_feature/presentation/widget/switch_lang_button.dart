import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../logic/language_cubit/language_cubit.dart';

class SwitchLangButton extends StatelessWidget {
  const SwitchLangButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        LangCubit.get(context).switchLang();
      },
      child: SizedBox(
        height: getWidgetHeight(48),
        width: getWidgetWidth(125),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblLanguageName,
              textColor: AppConstants.mainColor,
              textFontSize: AppConstants.fontSize18,
              textWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
