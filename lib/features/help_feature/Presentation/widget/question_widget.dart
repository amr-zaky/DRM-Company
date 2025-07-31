import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/extensions/shadow_bordered_widget.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../Domain/model/faq_model.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.faqModel}) : super(key: key);
  final FAQModel faqModel;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.padding8,
      ),
      decoration: const BoxDecoration().commonDecorationShadow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonTitleText(
                  textKey: widget.faqModel.question,
                  textWeight: FontWeight.w500,
                  textColor: isOpen
                      ? AppConstants.lightOffRedColor
                      : AppConstants.mainColor,
                  textHeight: 0,
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppConstants.lightGrayColor,
                )
              ],
            ),
          ),
          if (isOpen) ...<Widget>[
            getSpaceHeight(AppConstants.padding8),
            CommonTitleText(
              textKey: widget.faqModel.answer,
              textFontSize: AppConstants.fontSize14,
              textWeight: FontWeight.w500,
              textColor: AppConstants.borderInputColor,
              lines: 3,
            ),
          ]
        ],
      ),
    );
  }
}
