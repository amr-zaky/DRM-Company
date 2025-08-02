import 'package:base_project_repo/core/presentation/widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../language_feature/presentation/logic/language_cubit/language_cubit.dart';
import '../logic/on_boarding_cubit/on_boarding_cubit.dart';
import '../logic/on_boarding_cubit/on_boarding_states.dart';
import '../widget/on_boarding_button_actions.dart';
import '../widget/on_boarding_page.dart';
import '../widget/on_boarding_page_action.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key, required this.routeArgument})
      : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  late OnBoardingCubit onBoardingCubit;

  @override
  void initState() {
    super.initState();
    onBoardingCubit = OnBoardingCubit.get(context);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (BuildContext boardingCtx, OnBoardingStates boardingState) {},
        builder: (BuildContext boardingCtx, OnBoardingStates boardingState) {
          return Column(
            children: <Widget>[
              getSpaceHeight(65),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CommonAssetSvgImageWidget(
                      imageString: IconPath.appIcon,
                      height: 40,
                      width: 100,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        LangCubit.get(context).switchLang();
                      },
                      child: SizedBox(
                        height: getWidgetHeight(48),
                        width: getWidgetWidth(125),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CommonTitleText(
                              textKey:
                              AppLocalizations.of(context)!.lblLanguageName,
                              textColor: AppConstants.mainColor,
                              textFontSize: AppConstants.fontSize18,
                              textWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              getSpaceHeight(40),
              SizedBox(
                height: onBoardingCubit.currentIndex != 2
                    ? SharedText.screenHeight * 0.69
                    : SharedText.screenHeight * 0.61,
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: onBoardingCubit.onChangedFunction,
                  children: <Widget>[
                    OnBoardingPageItem(
                        pageImage: IconPath.onBoarding3Icon,
                        title: AppLocalizations.of(context)!
                            .lblWelcomeInDRM,
                        subTitle: AppLocalizations.of(context)!
                            .lblOnBoardingSub1),
                    OnBoardingPageItem(
                        pageImage: IconPath.onBoarding1Icon,
                        title: AppLocalizations.of(context)!
                            .lblUseOurFeature,
                        subTitle: AppLocalizations.of(context)!
                            .lblOnBoardingSub2),

                  ],
                ),
              ),
              if (onBoardingCubit.currentIndex != 1)
                OnBoardingPageAction(
                  onBoardingCubit: onBoardingCubit,
                  pageController: _pageController,
                )
              else
                const OnBoardingButtonAction(),
            ],
          );
        },
      ),
    );
  }
}
