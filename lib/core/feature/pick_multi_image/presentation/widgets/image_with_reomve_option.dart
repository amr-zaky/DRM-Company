import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/keys/icon_path.dart';
import '../../../../helpers/shared.dart';
import '../../../../presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../presentation/widgets/common_cached_image_widget.dart';
import '../../../../presentation/widgets/common_file_image_widget.dart';
import 'image_pop_up_widget.dart';

class ImageWithRemoveOption extends StatelessWidget {
  const ImageWithRemoveOption(
      {super.key,
      required this.imagePath,
      required this.isFile,
      required this.onRemoveClicked});
  final bool isFile;
  final String imagePath;
  final Function() onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (_) =>
                    imageDialog(imagePath, context, isFile: isFile));
          },
          child: isFile
              ? CommonFileImageWidget(
                  imagePath: imagePath,
                  width: 63,
                  height: 63,
                  radius: AppConstants.padding8,
                )
              : CommonCachedImageWidget(
                  imageUrl: imagePath,
                  width: 63,
                  height: 63,
                  radius: AppConstants.padding8,
                ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              onRemoveClicked();
            },
            child: Container(
              height: getWidgetHeight(16),
              width: getWidgetWidth(16),
              decoration: ShapeDecoration(
                color: AppConstants.lightRedColor.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius4)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CommonAssetSvgImageWidget(
                    imageString: IconPath.closeIcon,
                    imageColor: AppConstants.lightRedColor,
                    height: 14,
                    width: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}
