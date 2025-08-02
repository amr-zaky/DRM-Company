import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_cached_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({Key? key}) : super(key: key);

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppConstants.lightOffWhiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getWidgetHeight(AppConstants.padding8),
            horizontal: getWidgetWidth(AppConstants.padding8)),
        child: Row(children: <Widget>[
          ///User image
          CommonCachedImageWidget(
            imageUrl: SharedText.currentUser?.image ?? "",
            height: 48,
            width: 48,
            isProfile: true,
            isCircular: true,
            radius: 1000,
          ),
          getSpaceWidth(AppConstants.padding8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CommonTitleText(
                    textKey: SharedText.currentUser?.name ?? "",
                    textWeight: FontWeight.w600,
                  ),
                ],
              ),
              getSpaceHeight(AppConstants.padding4),
              Row(
                children: <Widget>[
                  const CommonAssetSvgImageWidget(
                    imageString: IconPath.settingIcon,
                    height: 16,
                    width: 16,
                  ),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblProfileSetting,
                    textWeight: FontWeight.w500,
                    textFontSize: AppConstants.fontSize12,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
