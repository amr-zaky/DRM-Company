import 'package:base_project_repo/core/data_source/network/dio_map_helper.dart';
import 'package:base_project_repo/core/helpers/responsive_ui/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/constants/theme/app_theme.dart';
import 'core/data_source/network/dio_helper.dart';
import 'core/helpers/firebase_service/firebase_service.dart';
import 'core/helpers/responsive_ui/ui_components.dart';
import 'core/helpers/shared_texts.dart';
import 'core/presentation/routes/route_generator.dart';
import 'features/language_feature/presentation/logic/language_cubit/language_cubit.dart';
import 'features/language_feature/presentation/logic/language_cubit/language_states.dart';
import 'multi_bloc_provider_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DioHelper.init();
    DioMapHelper.init();
    FirebaseService.getInstance();
    FirebaseService.getDeviceToken();
    FirebaseService.listenToForegroundNotification();
    FirebaseService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return const MultiBlocProvidersPage(
      body: OverlaySupport.global(
        child: HomeMaterialApp(),
      ),
    );
  }
}

class HomeMaterialApp extends StatelessWidget {
  const HomeMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangCubit, LangState>(
        listener: (BuildContext context, LangState langState) {},
        builder: (BuildContext langContext, LangState langState) {
          return InfoComponents(
            builder:
                (BuildContext infoComponentsContext, DeviceInfo deviceInfo) {
              SharedText.screenHeight = deviceInfo.screenHeight;
              SharedText.screenWidth = deviceInfo.screenWidth;
              SharedText.deviceType = deviceInfo;

              return MaterialApp.router(
                title: 'Base',
                theme: lightTheme,
                debugShowCheckedModeBanner: false,
                locale: LangCubit.get(context).appLocal,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: router,
              );
            },
          );
        });
  }
}
