import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';

class ChatTimeAndSeenWidget extends StatelessWidget {
  const ChatTimeAndSeenWidget(
      {Key? key,
      required this.isMe,
      required this.isSeen,
      required this.dateOfCreation})
      : super(key: key);
  final bool isMe;
  final bool isSeen;
  final String dateOfCreation;

  @override
  Widget build(BuildContext context) {
    debugPrint("is seen $isSeen");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isMe) ...<Widget>[
          Icon(
            isSeen ? Icons.done_all : Icons.check,
            size: 14,
            color: isSeen
                ? AppConstants.fetchReadCheckColor(isMe)
                : AppConstants.fetchUnReadCheckColor(isMe),
          ),
          getSpaceWidth(8),
          CommonTitleText(
            textKey: dateOfCreation,
            textColor: isMe
                ? AppConstants.lightBlackColor
                : AppConstants.lightBlackColor,
            minTextFontSize: AppConstants.fontSize14,
            textWeight: FontWeight.w500,
            lines: 50,
            textAlignment: isMe ? TextAlign.start : TextAlign.end,
          ),
        ] else ...<Widget>[
          CommonTitleText(
            textKey: dateOfCreation,
            textColor: isMe
                ? AppConstants.lightBlackColor
                : AppConstants.lightBlackColor,
            minTextFontSize: AppConstants.fontSize14,
            textWeight: FontWeight.w500,
            lines: 50,
            textAlignment: isMe ? TextAlign.start : TextAlign.end,
          ),
          getSpaceWidth(8),
          SizedBox(
            width: getWidgetWidth(16),
          ),
        ]
      ],
    );
  }
}
