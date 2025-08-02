import 'package:flutter/cupertino.dart';

import '/core/constants/app_constants.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({Key? key, required this.sectionContent})
      : super(key: key);
  final Widget sectionContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.18),
                blurRadius: 4)
          ]),
      child: sectionContent,
    );
  }
}
