import 'package:intl/intl.dart';

import '../shared_texts.dart';

extension FormatDateTimeToFullFormat on DateTime {
  String formatDateTimeToFullFormat() {
    final DateFormat dt =
        DateFormat('dd MMM , yyyy - hh:mm a', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDate() {
    final DateFormat dt = DateFormat('dd MMM , yyyy', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatTime() {
    final DateFormat dt = DateFormat('hh:mm a', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToBeUserFriendly() {
    final DateFormat dt = DateFormat('yyyy-MM-dd');

    return dt.format(this);
  }

  String formatDateTimeToChat() {
    String dateFormat = "";
    final DateFormat shortTime =
        DateFormat('hh:mm a', SharedText.currentLocale);
    final DateFormat longTime =
        DateFormat('dd / MM /yyyy ', SharedText.currentLocale);
    if (longTime.format(this) == longTime.format(DateTime.now())) {
      dateFormat = shortTime.format(this);
    } else {
      dateFormat = longTime.format(this);
    }

    return dateFormat;
  }

  String formatDateTimeToShowDayName() {
    final DateFormat dt = DateFormat('dd MMM ,yyyy', SharedText.currentLocale);

    return dt.format(this);
  }
}
