import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/lang_use_case.dart';
import '/core/helpers/shared_texts.dart';
import 'language_states.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit(this.useCase) : super(AppInitialLangState());
  final LangUseCase useCase;
  Locale? appLocal;

  static LangCubit get(BuildContext context) => BlocProvider.of(context);

  /// change lang with the new lang selected
  Future<void> changeLang(String newLang) async {
    ///update current lang
    appLocal = await useCase.callSetLang(lang: newLang);
    debugPrint(SharedText.currentLocale);
    emit(UpdateNewLangState());
  }

  ///get saved lang (called when app is opening)
  Future<void> getLang() async {
    emit(GetLangState());
    useCase.callGetLang().then((String value) {
      appLocal = Locale(value);
      emit(UpdateLangState());
    });
    emit(UpdateLangState());
  }

  void switchLang() {
    if (appLocal!.languageCode == "ar") {
      changeLang("en");
    } else {
      changeLang("ar");
    }
  }
}
