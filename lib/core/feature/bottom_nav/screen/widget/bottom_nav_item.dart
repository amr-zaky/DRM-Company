import 'package:base_project_repo/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/shared.dart';
import '../../../../presentation/widgets/common_asset_svg_image_widget.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.isSelected,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CommonAssetSvgImageWidget(
          imageString: image,
          width: 24,
          height: 24,
          imageColor: isSelected
              ? AppConstants.greenColor
              : AppConstants.lightBlackColor,
        ),
        getSpaceHeight(AppConstants.padding8),
        CommonTitleText(
            textKey: title,
            textColor: isSelected
                ? AppConstants.greenColor
                : AppConstants.lightBlackColor,
            textFontSize: AppConstants.padding12,
            textWeight: FontWeight.w500)
      ],
    );
  }
}
