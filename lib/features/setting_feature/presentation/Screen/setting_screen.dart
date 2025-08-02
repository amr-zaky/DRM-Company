import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../auth_feature/profile_feature/presentation/widget/user_profile_card.dart';
import '../../../language_feature/presentation/logic/language_cubit/language_cubit.dart';
import '../../../language_feature/presentation/widget/language_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/api_keys.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_bottom_sheet.dart';
import '/features/setting_feature/presentation/widget/notification_switch_widget.dart';
import 'setting_widget/section_content_item.dart';
import 'setting_widget/setting_section.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool enableRecommendation = true;
  late LangCubit langCubit = LangCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.padding16)),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getSpaceHeight(AppConstants.padding24 * 2),

                ///Setting title
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblSetting,
                  textColor: AppConstants.mainTextColor,
                ),

                ///Spacer
                getSpaceHeight(AppConstants.padding16),
                if (SharedText.currentUser != null) ...<Widget>[
                  ///User profile card
                  InkWell(
                      onTap: () {
                        context.pushNamed(RouteNames.profilePageRoute);
                      },
                      child: const UserProfileCard()),
                ],

                ///Spacer
                getSpaceHeight(AppConstants.padding8),

                ///my account
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblMyAccount,
                  textColor: AppConstants.mainTextColor,
                ),

                ///Spacer
                getSpaceHeight(AppConstants.padding8),

                ///App setting section
                SettingSection(
                  sectionContent: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.padding8),
                        vertical: getWidgetHeight(AppConstants.padding8)),
                    child: Column(
                      children: <Widget>[
                        ///Account setting
                        SectionContentItem(
                          title: AppLocalizations.of(context)!.lblAppSetting,
                          screenName: RouteNames.accountSettingPageRoute,
                        ),

                        ///notification
                        const NotificationSwitchWidget(),

                        ///Languages
                        SectionContentItem(
                          title: AppLocalizations.of(context)!.language,
                          onTap: () {
                            showBottomModalSheet(
                              context: context,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppConstants.padding16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CommonTitleText(
                                          textKey: AppLocalizations.of(context)!
                                              .lblSelectLanguage,
                                          textWeight: FontWeight.w500,
                                          minTextFontSize:
                                              AppConstants.fontSize16),
                                      InkWell(
                                        onTap: () => context.pop(),
                                        child: const CommonAssetSvgImageWidget(
                                            imageString: IconPath.closeIcon,
                                            height: 16,
                                            width: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                getSpaceHeight(24),

                                /// Languages
                                LanguageItem(
                                    onTap: () async {
                                      if (langCubit.appLocal!.languageCode ==
                                          "en") {
                                        context.pop();
                                        await langCubit.changeLang('ar');
                                      }
                                    },
                                    title:
                                        AppLocalizations.of(context)!.lblArabic,
                                    imagePath: IconPath.arabicIcon),
                                getSpaceHeight(AppConstants.padding16),
                                LanguageItem(
                                    onTap: () async {
                                      if (langCubit.appLocal!.languageCode ==
                                          "ar") {
                                        context.pop();
                                        await langCubit.changeLang('en');
                                      }
                                    },
                                    title: AppLocalizations.of(context)!
                                        .lblEnglish,
                                    imagePath: IconPath.englishIcon),
                              ],
                            );
                          },
                        ),

                        ///Call support
                        SectionContentItem(
                          title: AppLocalizations.of(context)!.lblCallSupport,
                          screenName: RouteNames.helpAndSupportPageRoute,
                          isLastItem: true,
                        ),

                        ///terms and conditions
                        // SectionContentItem(
                        //   title: AppLocalizations.of(context)!
                        //       .lblOutTermsAndConditions,
                        //   onTap: () {
                        //     context.pushNamed(RouteNames.settingPageRoute,
                        //         extra: RouteArgument(
                        //             pageTitle: AppLocalizations.of(context)!
                        //                 .lblTermsAndConditions,
                        //             pageType:
                        //                 ApiKeys.termsAndConditionsPageKey));
                        //   },
                        //   isLastItem: true,
                        //   // screenName: RouteNames.termsScreen,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
