import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/keys/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/custom_bottom_sheet.dart';
import '../../../language_feature/presentation/widget/language_widget.dart';
import '../../../setting_feature/presentation/Screen/setting_widget/section_content_item.dart';
import '../../../setting_feature/presentation/logic/setting_cubit/setting_cubit.dart';

class CallUsBottomSheet extends StatefulWidget {
  const CallUsBottomSheet({super.key});

  @override
  State<CallUsBottomSheet> createState() => _CallUsBottomSheetState();
}

class _CallUsBottomSheetState extends State<CallUsBottomSheet> {
  late SettingCubit settingCubit;

  @override
  void initState() {
    settingCubit = SettingCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SectionContentItem(
      title: AppLocalizations.of(context)!.lblCallUs,
      onTap: () {
        showBottomModalSheet(
          context: context,
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding16,
              vertical: AppConstants.padding24),
          children: <Widget>[
            ///header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblCallSupport,
                    textWeight: FontWeight.w500,
                    minTextFontSize: AppConstants.fontSize16),
                InkWell(
                  onTap: () => context.pop(),
                  child: const CommonAssetSvgImageWidget(
                      imageString: IconPath.closeIcon, height: 16, width: 16),
                ),
              ],
            ),
            getSpaceHeight(AppConstants.padding16),

            ///whatsApp
            LanguageItem(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      '''whatsapp://send?phone=+2${settingCubit.settingModel.sitePhone}''',
                    ),
                  );
                },
                title: AppLocalizations.of(context)!.lblWhatsApp,
                imagePath: IconPath.whatsappIcon),
            getSpaceHeight(AppConstants.padding8),

            ///phone
            LanguageItem(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      'tel:${settingCubit.settingModel.sitePhone}',
                    ),
                  );
                },
                title: AppLocalizations.of(context)!.lblPhoneCall,
                imagePath: IconPath.phoneCallIcon),
            getSpaceHeight(AppConstants.padding8),

            ///email
            LanguageItem(
              onTap: () async {
                await launchUrl(
                  Uri.parse(
                    "mailto:${settingCubit.settingModel.siteEmail!}",
                  ),
                );
              },
              title: AppLocalizations.of(context)!.lblEmail,
              imagePath: IconPath.emailMIcon,
            ),
            getSpaceHeight(AppConstants.padding32),
          ],
        );
      },
      isLastItem: true,
    );
  }
}
