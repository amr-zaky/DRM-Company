import 'dart:async';

import 'package:base_project_repo/core/presentation/widgets/common_asset_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../logic/splash_cubit/splash_cubit.dart';
import '../logic/splash_cubit/splash_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_title_text.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  late SplashCubit splashCubit;
  late AnimationController controller;
  late ValueNotifier<double> notifierController;

  @override
  void initState() {
    super.initState();
    splashCubit = SplashCubit.get(context);
    splashCubit.getCachedUser();

    notifierController = ValueNotifier<double>(0.0);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
        notifierController.value = controller.value;
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: BlocConsumer<SplashCubit, SplashStates>(
        listener: (BuildContext splashCtx, SplashStates splashState) {
          if (splashState is UserFoundState) {
            Timer(
                const Duration(milliseconds: 2500),
                () => context
                    .pushReplacementNamed(RouteNames.mainBottomNavPageRoute));
          } else if (splashState is UserNotFoundState) {
            Timer(
                const Duration(milliseconds: 2500),
                () => context.pushReplacementNamed(
                    RouteNames.onBoardingPageRoute,
                    extra: RouteArgument(
                        isUserFirstTime: splashState.isUserFirstTime)));
          }
        },
        builder: (BuildContext splashCtx, SplashStates splashState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Lottie.asset('assets/images/Drm_splash.json',),
          );
        },
      ),
    );
  }
}
