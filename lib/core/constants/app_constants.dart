import 'package:flutter/material.dart';

class AppConstants {
  /// Colors in Light Version ...
  static const Color mainColor = Color(0xff0D6BA6);
  static const Color mainTextColor = Color(0xff021042);
  static const Color secondTextColor = Color(0xff111D4C);
  static const Color lightGrayBackgroundColor = Color(0xff95969d);
  static const Color borderInputColor = Color(0xFFAFB0B6);
  static const Color lightBlackColor = Color(0xFF000000);
  static const Color successColor = Color(0xff30DE78);
  static const Color greenColor = Color(0xff118C46);
  static const Color greenLightColor = Color(0xff29BBC4);
  static const Color greenLightTwoColor = Color(0xffF2FBFB);
  static const Color lightGreyColor = Color(0xffDADADA);
  static const Color backBGColor = Color(0xFFFEFAFA);

  static const Color lightWhiteColor = Color(0xFFFFFFFF);
  static const Color lightOffWhiteColor = Color(0xFFF7FBFD);
  static const Color lightGrayColor = Color(0xFFE2E2E2);
  static const Color lightGrayOffColor = Color(0xFF646464);
  static const Color lightRedColor = Color(0xFFBF0000);
  static const Color appBarTitleColor = Color(0xff082640);
  static const Color lightOffRedColor = Color(0xFFBC3A59);
  static const Color circleProgressTextColor = Color(0xFF027437);
  static const Color greenTextColor = Color(0xFF17A68C);
  static const Color greyTextColor = Color(0xFFE2E3E3);
  static const Color splashColor = Color(0xFFFDFDFD);

  ///statusColor
  static const Color newStatusColor = Color(0xFF29BBC4);
  static const Color acceptedColor = Color(0xFF118C46);
  static const Color completedColor = Color(0xFF23D962);

  static const Gradient gradient = LinearGradient(colors: <Color>[
    Color(0xff74E8BE),
    Color(0xff7369F5),
  ]);
  static Gradient customGradient = const LinearGradient(
    begin: Alignment(-0.2, -1.0), // Adjusted for more curve
    end: Alignment(1.0, 0.8), // Adjusted for more curve
    colors: [
      Color(0xFF74E8BE),
      Color(0x407369F5), // Purple
    ],
    stops: [0.2, 0.99], // Adjusted stops for smoother transition
  );

  static const Color greyColor = Color(0xffA8A8A8);
  static const Color transparent = Colors.transparent;
  static const Color lightGrayOffTwoColor = Color(0xFFE6E6E6);

  static const Color shadowColor = Color(0x18000000);
  static const Color dividerColor = Color(0x1F1F1F26);

  static Color fetchUnReadCheckColor(bool isMe) =>
      isMe ? lightGreyColor : lightGrayBackgroundColor;

  static Color fetchReadCheckColor(bool isMe) =>
      isMe ? lightGreyColor : mainColor;

  /// Colors in Dark Version ...
  static const Color darkOffWhiteColor = Color(0XFFF6F6F6);
  static const Color darkBackgroundWidgetsColor = Color(0xFF212121);

  /// Font Sizes
  static const double fontSize7 = 7.0;
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize24 = 24.0;

  /// Border Radius
  static const double borderRadius4 = 4.0;
  static const double borderRadius6 = 6.0;
  static const double borderRadius8 = 8.0;
  static const double borderRadius10 = 10.0;
  static const double borderRadius15 = 15.0;
  static const double borderRadius18 = 18.0;
  static const double borderRadius20 = 20.0;
  static const double borderRadius24 = 24.0;
  static const double borderRadius25 = 25.0;
  static const double borderRadius32 = 32.0;
  static const double borderRadius40 = 40.0;

  /// Page Padding
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding20 = 20.0;
  static const double padding24 = 24.0;
  static const double padding32 = 32.0;
  static const double padding36 = 36.0;

  ///phone length
  static const int phoneLength = 9;
  static const int passwordMinLength = 8;

  ///Id length
  static const int idLength = 10;
  static const int imageMaxLength = 4;
}
