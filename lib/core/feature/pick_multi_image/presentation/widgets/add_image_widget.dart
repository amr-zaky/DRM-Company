import 'package:flutter/material.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidgetHeight(64),
      height: getWidgetHeight(64),
      padding: EdgeInsets.all(getWidgetHeight(AppConstants.padding8)),
      decoration: BoxDecoration(
        color: AppConstants.lightWhiteColor,
        borderRadius: BorderRadius.circular(AppConstants.padding8),
        border: Border.all(color: AppConstants.mainColor),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: CommonAssetSvgImageWidget(
          imageString: IconPath.plusIcon,
          width: 16,
          height: 16,
          imageColor: AppConstants.mainColor,
        ),
      ),
    );
  }
}
