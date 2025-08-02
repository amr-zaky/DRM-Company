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
    required this.selectedImage,
    required this.title,
  });

  final String image;
  final String selectedImage;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidgetWidth(52),
      height: getWidgetHeight(60),
      decoration: isSelected
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppConstants.lightBlackColor.withOpacity(0.08),
                    blurRadius: 8)
              ],
              gradient: AppConstants.gradient,
              color: AppConstants.lightWhiteColor,
            )
          : null,
      child: isSelected
          ? Padding(
              padding: const EdgeInsets.all(AppConstants.padding12),
              child: CommonAssetSvgImageWidget(
                imageString: selectedImage,
                width: 32,
                height: 32,
                imageColor: AppConstants.lightWhiteColor,
                fit: BoxFit.contain,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(AppConstants.padding8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CommonAssetSvgImageWidget(
                    imageString: image,
                    width: 22,
                    height: 22,
                    imageColor: AppConstants.lightBlackColor,
                    fit: BoxFit.contain,
                  ),
                  CommonTitleText(
                    textKey: title,
                    textFontSize: AppConstants.fontSize12,
                    textColor: AppConstants.appBarTitleColor,
                  )
                ],
              ),
            ),
    );
  }
}
