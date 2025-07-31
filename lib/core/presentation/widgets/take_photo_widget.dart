import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../constants/keys/icon_path.dart';
import '../../helpers/shared.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_list_item_widget.dart';
import 'common_title_text.dart';
import 'custom_bottom_sheet.dart';

void takePhotoBottomSheet(
    {required BuildContext context,
    Function(XFile)? getPhoto,
    bool multiImage = false,
    Function()? deleteImage,
    String? title}) {
  showBottomModalSheet(
      context: context,
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.padding16, vertical: AppConstants.padding24),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CommonTitleText(
                textKey:
                    title ?? AppLocalizations.of(context)!.lblProfilePicture,
                textWeight: FontWeight.w500,
                minTextFontSize: AppConstants.fontSize16,
                textColor: AppConstants.mainColor),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const CommonAssetSvgImageWidget(
                  imageString: IconPath.closeIcon, height: 16, width: 16),
            ),
          ],
        ),
        getSpaceHeight(AppConstants.padding16),
        if (deleteImage != null) ...<Widget>[
          CommonListItemWidget(
            onTap: () {
              deleteImage();
              Navigator.of(context, rootNavigator: true).pop();
            },
            title: AppLocalizations.of(context)!.lblDeleteImage,
            imagePath: IconPath.binIcon,
          ),
          getSpaceHeight(AppConstants.padding8)
        ],
        CommonListItemWidget(
            onTap: () {
              if (multiImage) {
                pickMultiImage(
                  getImage: getPhoto,
                  source: ImageSource.gallery,
                );
              } else {
                pickSingleImage(
                  getImage: getPhoto,
                  source: ImageSource.gallery,
                );
              }
              Navigator.of(context, rootNavigator: true).pop();
            },
            title: AppLocalizations.of(context)!.lblGallery,
            imagePath: IconPath.galleryIcon),
        getSpaceHeight(AppConstants.padding8),
        CommonListItemWidget(
            onTap: () {
              pickSingleImage(
                getImage: getPhoto,
                source: ImageSource.camera,
              );
              Navigator.of(context, rootNavigator: true).pop();
            },
            title: AppLocalizations.of(context)!.lblCamera,
            imagePath: IconPath.cameraIcon),
        getSpaceHeight(AppConstants.padding8),
      ]);
}

void pickSingleImage({
  required Function(XFile)? getImage,
  required ImageSource source,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
    );
    if (pickedFile == null) {
    } else {
      getImage!(pickedFile);
    }
  } catch (e) {
    debugPrint('Error Fetching Image: $e');
  }
}

void pickMultiImage({
  required Function(XFile)? getImage,
  required ImageSource source,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFile = await picker.pickMultiImage();
    if (pickedFile.isEmpty) {
    } else {
      for (final XFile element in pickedFile) {
        getImage!(element);
      }
    }
  } catch (e) {
    debugPrint('Error Fetching Image: $e');
  }
}
