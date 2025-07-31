import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class OnBoardingPageItem extends StatelessWidget {
  const OnBoardingPageItem(
      {Key? key,
      required this.pageImage,
      required this.title,
      required this.subTitle})
      : super(key: key);
  final String pageImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding16),
      child: Column(
        children: <Widget>[
          CommonAssetSvgImageWidget(
              imageString: pageImage, height: 255, width: 280),
          getSpaceHeight(40),
          CommonTitleText(
            textKey: title,
            textWeight: FontWeight.w500,
            textFontSize: AppConstants.fontSize20,
            textColor: AppConstants.mainTextColor,
            textAlignment: TextAlign.center,
            lines: 2,
            textHeight: 0,
          ),
          getSpaceHeight(AppConstants.padding16),
          CommonTitleText(
            textKey: subTitle,
            textFontSize: AppConstants.fontSize18,
            textColor: AppConstants.borderInputColor,
            lines: 3,
            textAlignment: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
