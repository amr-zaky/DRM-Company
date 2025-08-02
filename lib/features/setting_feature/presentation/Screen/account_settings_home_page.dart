import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../auth_feature/logout_feature/presentation/widget/logout_action.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import 'setting_widget/section_content_item.dart';
import 'setting_widget/setting_section.dart';

class AccountSettingsHomePage extends StatelessWidget {
  const AccountSettingsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblAppSetting,
        centerTitle: false,
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppConstants.padding16) +
                  EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, top: 2),
          child: Column(
            children: <Widget>[
              SettingSection(
                sectionContent: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidgetWidth(AppConstants.padding8),
                      vertical: getWidgetHeight(AppConstants.padding8)),
                  child: Column(children: <Widget>[
                    ///Change password
                    SectionContentItem(
                      title: AppLocalizations.of(context)!.lblChangePassWord,
                      screenName: RouteNames.changePasswordPageRoute,
                    ),

                    ///change phone number
                    SectionContentItem(
                      title:
                          AppLocalizations.of(context)!.lblChangeMobileNumber,
                      screenName: RouteNames.changePhoneNumberScreenRoute,
                    ),

                    ///Delete account
                    SectionContentItem(
                      title: AppLocalizations.of(context)!.lblDeleteAccount,
                      screenName: RouteNames.deleteAccountNoteScreenRoute,
                      isLastItem: true,
                    ),
                  ]),
                ),
              ),
              getSpaceHeight(AppConstants.padding8),

              /// LogOut
              const LogoutAction(),
            ],
          ),
        ),
      ),
    );
  }
}
