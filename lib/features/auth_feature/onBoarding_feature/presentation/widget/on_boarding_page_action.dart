import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../logic/on_boarding_cubit/on_boarding_cubit.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_title_text.dart';
import 'on_boarding_indicator.dart';

class OnBoardingPageAction extends StatelessWidget {
  const OnBoardingPageAction(
      {super.key, required this.onBoardingCubit, required this.pageController});
  final OnBoardingCubit onBoardingCubit;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear);
            onBoardingCubit.onChangedFunction(onBoardingCubit.currentIndex);
            onBoardingCubit.changeUserFirstTime();
          },
          child: SizedBox(
            width: getWidgetWidth(40),
            height: getWidgetHeight(40),
            child: Center(
              child: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblSkip,
                textWeight: FontWeight.w500,
                textFontSize: AppConstants.fontSize18,
                textColor: AppConstants.mainColor,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OnBoardingIndicator(
              positionIndex: 0,
              currentIndex: onBoardingCubit.currentIndex,
            ),
            getSpaceWidth(AppConstants.padding8),
            OnBoardingIndicator(
              positionIndex: 1,
              currentIndex: onBoardingCubit.currentIndex,
            ),
            getSpaceWidth(AppConstants.padding8),
            OnBoardingIndicator(
              positionIndex: 2,
              currentIndex: onBoardingCubit.currentIndex,
            ),
          ],
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            pageController.animateToPage(onBoardingCubit.currentIndex + 1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear);
            onBoardingCubit.onChangedFunction(onBoardingCubit.currentIndex);
            onBoardingCubit.changeUserFirstTime();
          },
          child: SizedBox(
            width: getWidgetWidth(40),
            height: getWidgetHeight(40),
            child: Center(
              child: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblNext,
                textWeight: FontWeight.w500,
                textFontSize: AppConstants.fontSize18,
                textColor: AppConstants.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
