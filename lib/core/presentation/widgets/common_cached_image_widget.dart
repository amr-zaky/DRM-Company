import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/keys/icon_path.dart';
import '../../helpers/shared.dart';
import 'common_asset_image_widget.dart';
import 'common_asset_svg_image_widget.dart';

class CommonCachedImageWidget extends StatelessWidget {
  const CommonCachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.isCircular = false,
    this.isProfile = false,
    this.radius = 0.0,
    this.fit = BoxFit.fill,
    this.imagePlaceHolder = IconPath.defPlaceHolderPNGImage,
  }) : super(key: key);
  final String imageUrl;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;
  final bool? isCircular;
  final bool? isProfile;
  final String imagePlaceHolder;

  @override
  Widget build(BuildContext context) {
    final double imageHeight = getWidgetHeight(height);
    final double imageWidth =
        isCircular! ? getWidgetHeight(height) : getWidgetWidth(width);

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) =>
              Container(
        height: imageHeight,
        width: imageWidth,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(
            radius!,
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (BuildContext context, String img) => Container(
        height: imageHeight,
        width: imageWidth,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius!,
          ),
        ),
        child: const Center(
            child: CircularProgressIndicator(
          color: AppConstants.mainColor,
        )),
      ),
      errorWidget: (BuildContext context, String url, Object error) =>
          isProfile!
              ? CommonAssetImageWidget(
                  imageString: 'avatar.png',
                  height: imageHeight,
                  width: imageWidth,
                  radius: radius,
                  fit: fit,
                )
              : CommonAssetSvgImageWidget(
                  imageString: imagePlaceHolder,
                  height: imageHeight,
                  width: imageWidth,
                  fit: fit!,
                  radius: radius!,
                  isCircular: isCircular!,
                ),
    );
  }
}
