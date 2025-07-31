import '/core/data_source/network/dio_helper.dart';

abstract class LanguageRemoteDataSourceInterface {
  Future<bool> setLang({required String lang});
}

class LanguageRemoteDataSourceImp extends LanguageRemoteDataSourceInterface {
  @override
  Future<bool> setLang({required String lang}) async {
    DioHelper.dio.options.headers
        .addAll(<String, dynamic>{"Accept-Language": lang});
    return true;
  }
}
