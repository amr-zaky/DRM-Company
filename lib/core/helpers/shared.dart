import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/features/auth_feature/logout_feature/presentation/logic/logout_cubit/logout_cubit.dart';
import 'shared_texts.dart';

/// Hide Keyboard
void hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

void checkUserAuth(
    {required BuildContext context,
    required CustomStatusCodeErrorType errorType}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  if (errorType == CustomStatusCodeErrorType.unVerified) {
    final LogoutCubit logoutCubit = BlocProvider.of<LogoutCubit>(context);
    logoutCubit.logOut();
    context.go(
      RouteNames.onBoardingPageRoute,
      extra: RouteArgument(isUserFirstTime: false),
    );
  }
}

/// Calculate %
String calculatePercentage(String price, String discount) {
  final String percent =
      ((double.parse(discount) * double.parse(price)) / (100))
          .toStringAsFixed(2);

  return percent;
}

/// Calculate Total Price
String calculateTotalPrice(String price, String discount) {
  final String finalPrice =
      (double.parse(price) - double.parse(calculatePercentage(price, discount)))
          .toStringAsFixed(2);

  return finalPrice;
}

/// Get Widget Height
double getWidgetHeight(double height) {
  final double currentHeight = SharedText.screenHeight * (height / 812);
  return currentHeight;
}

/// Get Widget Width
double getWidgetWidth(double width) {
  final double currentWidth = SharedText.screenWidth * (width / 375);
  return currentWidth;
}

/// Get Space Height
SizedBox getSpaceHeight(double height) {
  final double currentHeight = SharedText.screenHeight * (height / 812);
  return SizedBox(height: currentHeight);
}

/// Get Space Width
SizedBox getSpaceWidth(double width) {
  final double currentWidth = SharedText.screenWidth * (width / 375);
  return SizedBox(width: currentWidth);
}

///convert from sec to min
String secToMin(int sec) {
  return '${sec ~/ 60}:${sec % 60 >= 10 ? sec % 60 : '0${sec % 60}'}';
}
