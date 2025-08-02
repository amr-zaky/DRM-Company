import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.imagePath,
  });
  final Function() onTap;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getWidgetHeight(40),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.2),
                blurRadius: 4,
              )
            ],
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius4)),
        child: Row(
          children: <Widget>[
            getSpaceWidth(AppConstants.padding8),
            CommonAssetSvgImageWidget(
                imageString: imagePath, height: 15, width: 21),
            getSpaceWidth(AppConstants.padding4),
            Expanded(
              child: CommonTitleText(
                textKey: title,
                textColor: AppConstants.mainTextColor,
                minTextFontSize: AppConstants.fontSize12,
                textFontSize: AppConstants.fontSize12,
                textWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
