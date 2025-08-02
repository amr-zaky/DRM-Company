import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';

class OnBoardingIndicator extends StatelessWidget {
  const OnBoardingIndicator(
      {super.key, required this.currentIndex, required this.positionIndex});
  final int positionIndex, currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: positionIndex == currentIndex ? 30 : 8,
      decoration: BoxDecoration(
          color: positionIndex == currentIndex
              ? AppConstants.mainTextColor
              : AppConstants.lightOffWhiteColor,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
