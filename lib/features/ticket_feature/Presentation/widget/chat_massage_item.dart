import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../Domain/model/chat_model.dart';
import 'chat_message_header_widget.dart';

class ChatMassageItem extends StatelessWidget {
  const ChatMassageItem({Key? key, required this.isMe, required this.model})
      : super(key: key);
  final bool isMe;
  final ChatMassageModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: isMe
                ? AppConstants.mainTextColor
                : AppConstants.lightWhiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: <BoxShadow>[
              BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.16),
                blurRadius: 4,
              )
            ],
          ),
          constraints: BoxConstraints(
            minWidth: getWidgetWidth(50),
            maxWidth: getWidgetWidth(280),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              ChatMessageHeaderWidget(isMe: isMe),
              getSpaceHeight(AppConstants.padding8),
              CommonTitleText(
                textKey: model.massageContent!,
                textColor: isMe
                    ? AppConstants.lightWhiteColor
                    : AppConstants.borderInputColor,
                textFontSize: AppConstants.fontSize10,
                minTextFontSize: AppConstants.fontSize10,
                lines: 12,
                textAlignment: isMe ? TextAlign.start : TextAlign.end,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
