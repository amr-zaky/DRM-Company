import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/app_constants.dart';
import '../../constants/enums/exception_enums.dart';
import '../../helpers/shared.dart';
import 'common_title_text.dart';

class CommonErrorRowWidget extends StatelessWidget {

  const CommonErrorRowWidget(
      {super.key,
      this.withButton = false,
      this.onTap,
      this.errorMessage,
      this.errorType = CustomStatusCodeErrorType.init});
  final bool? withButton;
  final CustomStatusCodeErrorType errorType;
  final String? errorMessage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: SharedText.screenWidth*0.7,
          child: Row(
            children: [
              getSpaceWidth(AppConstants.padding8),
              Expanded(
                child: CommonTitleText(
                  textKey: errorType.getErrorMessage(context) ??
                      errorMessage ??
                      AppLocalizations.of(context)!.lblWrongHappen,
                  textFontSize: AppConstants.fontSize14,
                  textOverflow: TextOverflow.ellipsis,
                  textAlignment: TextAlign.start,
                  textWeight: FontWeight.w600,
                  textColor: AppConstants.lightBlackColor,
                ),
              ),
            ],
          ),
        ),
        if (withButton!) ...[
          getSpaceWidth(AppConstants.padding16),
          IconButton(
            onPressed: onTap ?? () {},
            icon: const Icon(Icons.refresh),
            color: AppConstants.lightRedColor,
          )
        ]
      ],
    );
  }
}
