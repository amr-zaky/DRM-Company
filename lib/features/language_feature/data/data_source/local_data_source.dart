import '/core/constants/keys/local_keys.dart';
import '/core/data_source/local_source/shared_prefs_imp.dart';

abstract class LanguageLocalDataSourceInterface {
  Future<bool> setLang({required String lang});

  Future<String?> getLang();
}

class LanguageLocalDataSourceImp extends LanguageLocalDataSourceInterface {
  @override
  Future<String?> getLang() async {
    return SharedPrefs.getString(DbKeys.lang);
  }

  @override
  Future<bool> setLang({required String lang}) async {
    return SharedPrefs.setString(DbKeys.lang, lang);
  }
}
