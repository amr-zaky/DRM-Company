import 'package:flutter/material.dart';

import 'device_info.dart';
import 'get_device_type.dart';

class InfoComponents extends StatelessWidget {
  const InfoComponents({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrains) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        final DeviceInfo deviceInfo = DeviceInfo(
            orientation: mediaQueryData.orientation,
            deviceType: getDeviceType(mediaQueryData),
            screenWidth: mediaQueryData.size.width,
            screenHeight: mediaQueryData.size.height,
            widgetHeight: constrains.maxHeight,
            widgetWidth: constrains.maxWidth);

        return builder(context, deviceInfo);
      },
    );
  }
}
