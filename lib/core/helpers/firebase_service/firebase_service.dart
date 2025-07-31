import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../constants/app_constants.dart';
import '../../presentation/widgets/common_title_text.dart';
import '../shared.dart';
import '../shared_texts.dart';

class FirebaseService {
  /// Private Constructor
  FirebaseService._internal();

  /// Singleton
  static FirebaseService? _instance;
  static FirebaseMessaging? messaging;

  // ignore: prefer_constructors_over_static_methods
  static FirebaseService getInstance() {
    _instance ??= FirebaseService._internal();

    messaging ??= FirebaseMessaging.instance;

    return _instance!;
  }

  static Future<FirebaseApp> initializeNotificationApp() async {
    return Firebase.initializeApp();
  }

  /// Get Device Token
  static void getDeviceToken() {
    messaging!.getToken().then((String? value) {
      SharedText.deviceToken = value!;
    });
  }

  /// Listen To Notification in ForeGround
  static void listenToForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonTitleText(
                textKey: event.data['title'],
                textWeight: FontWeight.w500,
                textColor: AppConstants.lightWhiteColor,
              ),
              getSpaceWidth(5),
              CommonTitleText(
                textKey: event.data['message'],
                textFontSize: AppConstants.fontSize14,
                textColor: AppConstants.lightWhiteColor,
              ),
            ],
          ),
          elevation: 0.0,
          background: AppConstants.mainColor);
    });
  }

  /// Request Notification Permission
  static void requestPermission() {
    messaging!.requestPermission();
  }
}
