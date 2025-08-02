import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/shared.dart';
import '../../../core/presentation/widgets/common_title_text.dart';
import '../domain/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: model.isRead!
            ? AppConstants.lightGreyColor
            : AppConstants.lightWhiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConstants.shadowColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// title
            CommonTitleText(
              textKey: model.title ?? "Order Status",
              textWeight: FontWeight.w500,
              textFontSize: AppConstants.fontSize14,
              textColor: AppConstants.mainColor,
            ),

            /// Space
            getSpaceHeight(AppConstants.padding4),

            /// Time
            Row(
              children: <Widget>[
                if (model.isRead!) ...<Widget>[
                  Container(
                    width: getWidgetWidth(8),
                    height: getWidgetHeight(8),
                    decoration: const BoxDecoration(
                        color: AppConstants.mainColor, shape: BoxShape.circle),
                  ),
                  getSpaceWidth(AppConstants.padding4)
                ],
                CommonTitleText(
                  textKey: model.createdAt ?? "8 hrs ago",
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.fontSize14,
                  textColor: AppConstants.mainColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
