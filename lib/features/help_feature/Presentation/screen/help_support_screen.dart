import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../setting_feature/presentation/Screen/setting_widget/section_content_item.dart';
import '../../../setting_feature/presentation/Screen/setting_widget/setting_section.dart';
import '../widget/call_us_bottom_sheet.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblHelpAndSupport,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(AppConstants.padding16),
        ),
        child: SettingSection(
          sectionContent: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.padding8),
                vertical: getWidgetHeight(AppConstants.padding8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SectionContentItem(
                  title: AppLocalizations.of(context)!.lblFAQ,
                  screenName: RouteNames.questionsPageRoute,
                ),
                SectionContentItem(
                  title: AppLocalizations.of(context)!.lblSendRequestTitle,
                  screenName: RouteNames.contactPageRoute,
                ),
                SectionContentItem(
                  title: AppLocalizations.of(context)!.lblHaveProblem,
                  screenName: RouteNames.ticketListPageRoute,
                ),
                const CallUsBottomSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
