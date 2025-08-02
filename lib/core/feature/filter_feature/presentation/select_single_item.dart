import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/shared_texts.dart';
import '../../../presentation/widgets/common_cached_image_widget.dart';
import '../../../presentation/widgets/common_title_text.dart';
import '../domain/model/search_filter_model.dart';

class PopUpSingleItem extends StatelessWidget {
  const PopUpSingleItem(
      {Key? key,
      required this.model,
      required this.isSelected,
      required this.withImage})
      : super(key: key);
  final SelectableModel model;
  final bool isSelected;
  final bool withImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(47),
      margin: const EdgeInsets.all(3),
      width: SharedText.screenWidth,
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(AppConstants.padding8),
          horizontal: getWidgetWidth(12)),
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius4),
          border: Border.all(
              color: isSelected
                  ? AppConstants.mainColor
                  : AppConstants.transparent),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.08),
                blurRadius: 8),
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (withImage) ...<Widget>[
                  CommonCachedImageWidget(
                      imageUrl: model.image!, height: 24, width: 24),
                  getSpaceWidth(AppConstants.padding8),
                ],
                CommonTitleText(
                  textKey: model.name.toString(),
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.fontSize12,
                ),
              ],
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppConstants.mainColor,
                size: 18,
              )
            else
              const SizedBox()
          ]),
    );
  }
}
