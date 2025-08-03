import 'package:base_project_repo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../constants/app_constants.dart';
import '../../presentation/widgets/common_title_text.dart';
import '../shared.dart';
import '../shared_texts.dart';
import '../local_notification_service.dart';

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
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Get Device Token
  static void getDeviceToken() {
    messaging!.getToken().then((String? value) {
      debugPrint("Device token: $value");
      SharedText.deviceToken = value!;
    });
  }

  /// Listen To Notification in ForeGround
  static void listenToForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // Use local notifications for custom sound support
      LocalNotificationService.showNotificationFromFirebase(event);

      // Also show in-app notification for immediate feedback
      showSimpleNotification(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonTitleText(
                textKey: event.notification?.title ??
                    event.data['title'] ??
                    'New Notification',
                textWeight: FontWeight.w500,
                textColor: AppConstants.lightWhiteColor,
              ),
              getSpaceWidth(5),
              CommonTitleText(
                textKey: event.notification?.body ??
                    event.data['message'] ??
                    'You have a new message',
                textFontSize: AppConstants.fontSize14,
                textColor: AppConstants.lightWhiteColor,
              ),
            ],
          ),
          elevation: 0.0,
          background: AppConstants.mainColor);
    });
  }

  /// Listen To Background Notifications
  static void listenToBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Request Notification Permission
  static void requestPermission() {
    messaging!.requestPermission();
    LocalNotificationService.requestPermissions();
  }

  /// Initialize All Notification Services
  static void initializeAllNotificationServices() {
    // Initialize the FirebaseService instance first
    getInstance();

    getDeviceToken();
    requestPermission();
    listenToForegroundNotification();
    listenToBackgroundNotification();
    LocalNotificationService.initialize();
  }
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  LocalNotificationService.initialize();
  await LocalNotificationService.showNotificationFromFirebase(message);
  debugPrint('Handling background message: ${message.messageId}');
}
