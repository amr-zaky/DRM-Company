import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/data_source/local_source/shared_prefs_imp.dart';
import 'core/helpers/firebase_service/firebase_service.dart';
import 'core/helpers/observers/bloc_observer.dart';
import 'injection_container.dart' as di;
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.init();
  await di.init();
  await FirebaseService.initializeNotificationApp();
  FirebaseService.initializeAllNotificationServices();

  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppConstants.lightBlackColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}
