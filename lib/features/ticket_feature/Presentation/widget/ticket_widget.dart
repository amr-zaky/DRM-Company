import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/extensions/format_date_time_to_time_only.dart';
import '../../../../core/helpers/extensions/shadow_bordered_widget.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../Domain/model/ticket_model.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({Key? key, required this.model}) : super(key: key);
  final TicketModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.all(getWidgetHeight(AppConstants.padding12)),
        decoration: const BoxDecoration().commonDecorationShadow(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: CommonTitleText(
                      textKey: model.subject,
                      textWeight: FontWeight.w600,
                      minTextFontSize: AppConstants.fontSize16),
                ),
                getSpaceWidth(AppConstants.padding8),
                if (model.isOpen)
                  Container(
                    width: getWidgetWidth(72),
                    height: getWidgetHeight(24),
                    decoration: BoxDecoration(
                        color: AppConstants.circleProgressTextColor
                            .withOpacity(0.08),
                        borderRadius:
                            BorderRadius.circular(AppConstants.borderRadius25)),
                    child: Center(
                      child: CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblOpen,
                        textColor: AppConstants.circleProgressTextColor,
                        textFontSize: AppConstants.fontSize12,
                      ),
                    ),
                  )
                else
                  Container(
                    width: getWidgetWidth(72),
                    height: getWidgetHeight(24),
                    decoration: BoxDecoration(
                        color: AppConstants.lightRedColor.withOpacity(0.08),
                        borderRadius:
                            BorderRadius.circular(AppConstants.borderRadius25)),
                    child: Center(
                      child: CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblClose,
                        textColor: AppConstants.lightRedColor,
                        textFontSize: AppConstants.fontSize12,
                      ),
                    ),
                  )
              ],
            ),
            getSpaceHeight(AppConstants.padding8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonTitleText(
                  textKey: model.category,
                  textFontSize: AppConstants.fontSize14,
                  textColor: AppConstants.borderInputColor,
                ),
                getSpaceWidth(AppConstants.padding8),
                CommonTitleText(
                    textKey: model.date.formatDate(),
                    textColor: AppConstants.borderInputColor,
                    textFontSize: AppConstants.fontSize12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
