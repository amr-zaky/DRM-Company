import 'package:flutter/material.dart';
import '../../constants/enums/device_enums.dart';

class DeviceInfo {
  DeviceInfo(
      {required this.orientation,
      required this.deviceType,
      required this.screenHeight,
      required this.screenWidth,
      required this.widgetHeight,
      required this.widgetWidth});
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenHeight;
  final double screenWidth;
  final double widgetHeight;
  final double widgetWidth;
}
