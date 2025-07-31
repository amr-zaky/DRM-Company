import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_cached_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class ChatMessageHeaderWidget extends StatelessWidget {
  const ChatMessageHeaderWidget({super.key, required this.isMe});
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return isMe
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CommonTitleText(
                textKey: SharedText.currentUser!.name!,
                textColor: AppConstants.lightWhiteColor,
                textFontSize: AppConstants.fontSize12,
                textWeight: FontWeight.w500,
                textHeight: 0,
              ),
              getSpaceWidth(AppConstants.padding4),
              CommonCachedImageWidget(
                imageUrl: SharedText.currentUser!.image!,
                width: 24,
                height: 24,
                isProfile: true,
                radius: 1000,
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: AppConstants.backBGColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: AppConstants.shadowColor,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: const CommonAssetSvgImageWidget(
                  imageString: IconPath.callSupportIcon,
                  height: 16,
                  width: 16,
                ),
              ),
              getSpaceWidth(AppConstants.padding4),
              CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblSupport,
                textColor: AppConstants.mainTextColor,
                textFontSize: AppConstants.fontSize12,
                textWeight: FontWeight.w500,
                textHeight: 0,
              ),
            ],
          );
  }
}
