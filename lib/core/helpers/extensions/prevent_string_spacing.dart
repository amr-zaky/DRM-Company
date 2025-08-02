import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension GetStringWithoutSpacings on String {
  String getStringWithoutSpacings() {
    String firstName = split(" ").first;
    if (firstName.length > 12) {
      firstName = firstName.substring(0, 10);
      return firstName[0].toUpperCase() + firstName.substring(1);
    } else {
      return firstName[0].toUpperCase() + firstName.substring(1);
    }
  }

  String hidePhoneNumberData() {
    return "${substring(0, 4)}xxxxxxx${substring(length - 1)}";
  }

  String hideEmail() {
    final int emailIndex = indexOf("@");

    return "${substring(0, 2)}xxxxxxx${substring(emailIndex)}";
  }

  String addPhoneCountryCode() {
    String countryCode = "+966";

    return countryCode +=this;
  }

  String addSARToText(BuildContext context) {
    return "$this ${AppLocalizations.of(context)!.lblSAR} ";
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((String str) => str.toCapitalized())
          .join(' ');
}
