import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../constants/keys/icon_path.dart';
import '../../helpers/shared.dart';
import '/core/presentation/widgets/take_photo_widget.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_cached_image_widget.dart';
import 'common_file_image_widget.dart';

class CommonPersonImageWidget extends StatelessWidget {
  const CommonPersonImageWidget(
      {Key? key,
      required this.context,
      required this.pickPhoto,
      this.pickedImage,
      this.cacheImage,
      required this.deletePhoto})
      : super(key: key);
  final BuildContext context;
  final Function(XFile)? pickPhoto;
  final Function() deletePhoto;
  final XFile? pickedImage;
  final String? cacheImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            takePhotoBottomSheet(context: context, getPhoto: pickPhoto);
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: getWidgetHeight(90),
                height: getWidgetHeight(90),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.lightWhiteColor,
                ),
                child: pickedImage != null
                    ? CommonFileImageWidget(
                        imagePath: pickedImage!.path,
                        height: 90,
                        width: 90,
                        radius: 1000)
                    : cacheImage != null
                        ? CommonCachedImageWidget(
                            imageUrl: cacheImage!,
                            height: 90,
                            width: 90,
                            radius: 1000,
                            isCircular: true,
                            isProfile: true)
                        : const Padding(
                            padding: EdgeInsets.all(25),
                            child: CommonAssetSvgImageWidget(
                              imageString: IconPath.cameraIcon,
                              imageColor: AppConstants.mainColor,
                              height: 32,
                              width: 32,
                              fit: BoxFit.contain,
                            ),
                          ),
              ),
              if (pickedImage == null)
                const SizedBox()
              else
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () {
                        deletePhoto();
                      },
                      child: Container(
                        height: getWidgetHeight(24),
                        width: getWidgetWidth(24),
                        decoration: const BoxDecoration(
                            color: AppConstants.mainColor,
                            shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CommonAssetSvgImageWidget(
                              imageString: IconPath.binIcon,
                              height: 12,
                              width: 12),
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
