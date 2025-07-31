import '../../domain/interface/lang_interface.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

class LangRepository extends LangInterface {
  LangRepository(
      {required this.localDataSourceInterface,
      required this.remoteDataSourceInterface});
  final LanguageLocalDataSourceInterface localDataSourceInterface;
  final LanguageRemoteDataSourceInterface remoteDataSourceInterface;

  @override
  Future<String?> getLang() {
    return localDataSourceInterface.getLang().then((String? value) {
      remoteDataSourceInterface.setLang(lang: value ?? "en");
      return value;
    });
  }

  @override
  Future<bool> setLang({required String lang}) {
    return localDataSourceInterface
        .setLang(lang: lang)
        .then((bool value) => remoteDataSourceInterface.setLang(lang: lang));
  }
}
