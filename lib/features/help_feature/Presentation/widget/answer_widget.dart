import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key, required this.answerName}) : super(key: key);
  final String answerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CommonAssetSvgImageWidget(
            imageString: 'answer.svg', height: 16, width: 16),
        getSpaceWidth(AppConstants.padding4),
        CommonTitleText(
            textKey: answerName,
            textFontSize: AppConstants.fontSize14,
            textWeight: FontWeight.w500,
            textColor: AppConstants.mainColor),
      ],
    );
  }
}
