abstract class LangInterface {
  Future<bool> setLang({required String lang});

  Future<String?> getLang();
}
