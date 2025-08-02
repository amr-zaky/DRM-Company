import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

abstract class SwitchFactory {
  factory SwitchFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSwitch();
      case TargetPlatform.iOS:
        return IOSSwitch();

      default:
        return AndroidSwitch();
    }
  }
  Widget buildSwitch(
      {required bool value, required Function(bool p1) onChanged});
}

class AndroidSwitch implements SwitchFactory {
  @override
  Widget buildSwitch(
      {required bool value, required Function(bool p1) onChanged}) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppConstants.lightWhiteColor,
      activeTrackColor: AppConstants.successColor,
    );
  }
}

class IOSSwitch implements SwitchFactory {
  @override
  Widget buildSwitch(
      {required bool value, required Function(bool p1) onChanged}) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: AppConstants.lightGreyColor,
      trackColor: AppConstants.successColor,
    );
  }
}

class PlatformSwitch {
  static Widget buildSwitch(
      {required BuildContext context,
      required bool value,
      required Function(bool p1) onChanged}) {
    return SwitchFactory(Theme.of(context).platform)
        .buildSwitch(value: value, onChanged: onChanged);
  }
}
