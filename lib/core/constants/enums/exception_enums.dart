import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CustomStatusCodeErrorType {
  init,
  server,
  internet,
  gatWay,
  redirection,
  connectTimeout,
  receiveTimeout,
  sendTimeout,
  badRequest,
  unExcepted,
  unVerified,
  notFound,
  parsing,
}

extension ErrorTypeMessage on CustomStatusCodeErrorType {
  String? getErrorMessage(BuildContext context) {
    final Map<CustomStatusCodeErrorType, String> typeError =
        <CustomStatusCodeErrorType, String>{
      CustomStatusCodeErrorType.internet:
          AppLocalizations.of(context)!.lblCheckInternet,
    };
    return typeError[this];
  }
}
