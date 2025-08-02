import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key, required this.onImageClicked});
  final Function() onImageClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            onImageClicked();
          },
          child: Container(
            width: SharedText.screenWidth,
            decoration: BoxDecoration(
              color: AppConstants.lightWhiteColor,
              border: Border.all(
                color: AppConstants.borderInputColor,
                width: .4,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppConstants.lightBlackColor.withOpacity(0.14),
                  blurRadius: 4,
                )
              ],
              borderRadius: BorderRadius.circular(AppConstants.borderRadius24),
            ),
            padding: EdgeInsets.symmetric(
                    vertical: getWidgetHeight(AppConstants.padding12),
                    horizontal: getWidgetWidth(AppConstants.padding16)) +
                EdgeInsets.only(
                    bottom: getWidgetHeight(AppConstants.padding24)),
            child: Row(
              children: <Widget>[
                const CommonAssetSvgImageWidget(
                    imageString: IconPath.uploadIcon, height: 16, width: 16),
                getSpaceWidth(AppConstants.padding8),
                Expanded(
                  child: CommonTitleText(
                    textKey:
                        AppLocalizations.of(context)!.lblMakeSureAllDataClear,
                    textWeight: FontWeight.w500,
                    textFontSize: AppConstants.fontSize14,
                    minTextFontSize: AppConstants.fontSize14,
                    textColor: AppConstants.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        getSpaceHeight(AppConstants.padding8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblPhotoRestriction,
                textFontSize: AppConstants.fontSize10,
                minTextFontSize: AppConstants.fontSize10,
                textColor: AppConstants.greyColor,
                lines: 2,
                textAlignment: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }
}
