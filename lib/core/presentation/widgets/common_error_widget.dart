import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/app_constants.dart';
import '../../constants/enums/exception_enums.dart';
import '../../helpers/shared.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_global_button.dart';
import 'common_title_text.dart';

class CommonError extends StatelessWidget {
  const CommonError(
      {Key? key,
      this.errorMassage,
      this.withButton = false,
      this.onTap,
      this.imageHeight = 80,
      this.imageWidth = 80,
      this.errorType = CustomStatusCodeErrorType.init})
      : super(key: key);
  final String? errorMassage;
  final bool? withButton;
  final CustomStatusCodeErrorType errorType;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CommonAssetSvgImageWidget(
              imageString: "error_icon.svg",
              height: imageHeight!,
              width: imageWidth!),
        ),
        getSpaceHeight(AppConstants.padding16),
        CommonTitleText(
          textKey: errorType.getErrorMessage(context) ??
              AppLocalizations.of(context)!.lblWrongHappen,
          textFontSize: AppConstants.fontSize14,
          textOverflow: TextOverflow.ellipsis,
          textAlignment: TextAlign.center,
          textWeight: FontWeight.w600,
        ),
        getSpaceHeight(AppConstants.padding8),
        if (errorType != CustomStatusCodeErrorType.internet)
          Row(
            children: <Widget>[
              Expanded(
                child: CommonTitleText(
                  textKey: errorMassage == null || errorMassage!.isEmpty
                      ? AppLocalizations.of(context)!.lblWrongHappen
                      : errorMassage!,
                  minTextFontSize: AppConstants.fontSize16,
                  textColor: AppConstants.greyColor,
                  textOverflow: TextOverflow.ellipsis,
                  textAlignment: TextAlign.center,
                  lines: 2,
                ),
              ),
            ],
          ),
        if (withButton!) ...<Widget>[
          getSpaceHeight(AppConstants.padding16),
          CommonGlobalButton(
              radius: AppConstants.borderRadius8,
              width: 140,
              buttonBackgroundColor: AppConstants.transparent,
              onPressedFunction: onTap ?? () {},
              buttonText: AppLocalizations.of(context)!.lblRetry,
              showBorder: true,
              buttonTextColor: AppConstants.mainColor)
        ]
      ],
    );
  }
}
