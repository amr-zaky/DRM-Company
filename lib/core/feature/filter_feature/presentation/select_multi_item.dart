import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/shared_texts.dart';
import '../../../presentation/widgets/common_title_text.dart';
import '../domain/model/search_filter_model.dart';

class PopUpMultiItem extends StatelessWidget {
  const PopUpMultiItem(
      {Key? key, required this.model, required this.isSelected})
      : super(key: key);
  final SelectableModel model;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(47),
      width: SharedText.screenWidth,
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(13),
          horizontal: getWidgetWidth(AppConstants.padding16)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CommonTitleText(
              textKey: model.name!,
              textWeight: FontWeight.w600,
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppConstants.lightBlackColor,
                size: 20,
              )
          ]),
    );
  }
}
