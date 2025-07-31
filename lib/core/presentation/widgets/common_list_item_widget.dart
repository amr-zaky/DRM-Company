import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class CommonListItemWidget extends StatelessWidget {
  const CommonListItemWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.imagePath,
  });
  final Function() onTap;
  final String title;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getWidgetHeight(40),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppConstants.shadowColor.withOpacity(0.019),
                blurRadius: 4,
              )
            ],
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius4)),
        child: Row(
          children: <Widget>[
            getSpaceWidth(AppConstants.padding8),
            if (imagePath != null) ...<Widget>[
              CommonAssetSvgImageWidget(
                  imageString: imagePath!, height: 16, width: 16),
              getSpaceWidth(AppConstants.padding4),
            ],
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
