import 'package:flutter/material.dart';

import '../app_constants.dart';

ThemeData lightTheme = ThemeData(
  /// Font Family
  fontFamily: 'Cairo',
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// Colors
  scaffoldBackgroundColor: AppConstants.lightWhiteColor,
  primaryColor: AppConstants.lightWhiteColor,
  hintColor: AppConstants.lightGreyColor,
  dividerColor: AppConstants.transparent,
  focusColor: AppConstants.lightGreyColor,
  shadowColor: AppConstants.lightGreyColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0, foregroundColor: AppConstants.mainColor),
  dialogBackgroundColor: AppConstants.lightWhiteColor,

  /// Brightness
  brightness: Brightness.light,

  /// Text Themes
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.borderInputColor,
        height: 1.3),
    displayMedium: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.borderInputColor,
        height: 1.3),
    displaySmall: TextStyle(
        fontSize: AppConstants.fontSize16,
        fontWeight: FontWeight.w500,
        color: AppConstants.borderInputColor,
        height: 1.3),
    headlineMedium: TextStyle(
        fontSize: AppConstants.fontSize20,
        fontWeight: FontWeight.w500,
        color: AppConstants.borderInputColor,
        height: 1.3),
    headlineSmall: TextStyle(
        fontSize: AppConstants.borderRadius18,
        fontWeight: FontWeight.w700,
        color: AppConstants.borderInputColor,
        height: 1.3),
    titleLarge: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w700,
        color: AppConstants.borderInputColor,
        height: 1.3),
    titleMedium: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    titleSmall: TextStyle(
        fontSize: AppConstants.fontSize20,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    bodySmall: TextStyle(
        fontSize: AppConstants.fontSize16,
        fontWeight: FontWeight.w500,
        color: AppConstants.borderInputColor,
        height: 1.2),
  ),
);

ThemeData darkTheme = ThemeData(
  /// Font Family
  fontFamily: 'Montserrat',
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// Colors
  scaffoldBackgroundColor: AppConstants.lightBlackColor,
  primaryColor: AppConstants.darkBackgroundWidgetsColor,
  hintColor: AppConstants.lightGreyColor,
  dividerColor: AppConstants.transparent,
  shadowColor: AppConstants.lightGreyColor,

  /// Brightness
  brightness: Brightness.dark,

  /// Text Themes
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    displayMedium: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    displaySmall: TextStyle(
        fontSize: AppConstants.fontSize16,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headlineMedium: TextStyle(
        fontSize: AppConstants.fontSize20,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headlineSmall: TextStyle(
        fontSize: AppConstants.borderRadius18,
        fontWeight: FontWeight.w700,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    titleLarge: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w700,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    titleMedium: TextStyle(
        fontSize: AppConstants.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    titleSmall: TextStyle(
        fontSize: AppConstants.fontSize20,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    bodySmall: TextStyle(
        fontSize: AppConstants.fontSize16,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.2),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppConstants.mainColor),
);
