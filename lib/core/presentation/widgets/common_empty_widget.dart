import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import '../../helpers/shared_texts.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_global_button.dart';
import 'common_title_text.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imageString,
      required this.titleKey,
      required this.imageHeight,
      required this.imageWidth,
      this.description,
      this.withButton = false,
      this.onTap,
      this.buttonText})
      : super(key: key);
  final String imageString;
  final double imageHeight;
  final double imageWidth;
  final String titleKey;
  final String? description;
  final bool? withButton;
  final Function()? onTap;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SharedText.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CommonAssetSvgImageWidget(
                imageString: imageString,
                height: imageHeight,
                width: imageWidth),
          ),
          getSpaceHeight(AppConstants.padding16),
          Center(
            child: CommonTitleText(
              textKey: titleKey,
              textFontSize: AppConstants.fontSize18,
              lines: 2,
              textColor: AppConstants.greenColor,
              textOverflow: TextOverflow.ellipsis,
              textAlignment: TextAlign.center,
              textWeight: FontWeight.w600,
            ),
          ),
          if (description != null) ...<Widget>[
            getSpaceHeight(AppConstants.padding8),
            Center(
              child: CommonTitleText(
                textKey: description!,
                lines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlignment: TextAlign.center,
                textColor: AppConstants.lightGrayOffColor,
                textWeight: FontWeight.w500,
              ),
            ),
          ],
          if (withButton!) ...<Widget>[
            getSpaceHeight(AppConstants.padding8),
            CommonGlobalButton(
                radius: AppConstants.borderRadius8,
                width: 140,
                buttonBackgroundColor: AppConstants.lightGrayBackgroundColor,
                onPressedFunction: onTap ?? () {},
                buttonText:
                    buttonText ?? AppLocalizations.of(context)!.lblRetry,
                buttonTextColor: AppConstants.mainColor)
          ]
        ],
      ),
    );
  }
}
