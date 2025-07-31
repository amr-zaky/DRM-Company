import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helpers/shared_texts.dart';
import '../interface/lang_interface.dart';

class LangUseCase {
  LangUseCase(this.langInterface);
  final LangInterface langInterface;

  Future<Locale> callSetLang({required String lang}) {
    return langInterface.setLang(lang: lang).then((bool value) async {
      SharedText.currentLocale = lang;
      await AppLocalizations.delegate.load(Locale(lang));
      return Locale(lang);
    });
  }

  Future<String> callGetLang() {
    return langInterface.getLang().then((String? value) async {
      if (value == null) {
        callSetLang(lang: 'ar');
        return Future<String>(() => 'ar');
      } else {
        SharedText.currentLocale = value;
        await AppLocalizations.delegate.load(Locale(value));
        return Future<String>(() => value);
      }
    });
  }
}
