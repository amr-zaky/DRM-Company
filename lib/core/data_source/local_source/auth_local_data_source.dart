import 'dart:convert';

import '../../constants/enums/exception_enums.dart';
import '../../model/auth_base_model.dart';
import '/core/constants/keys/local_keys.dart';
import '/core/data_source/local_source/shared_prefs_imp.dart';

abstract class AuthLocalDataSourceInterface {
  Future<bool> setUserMap(String value);

  Future<bool> setIsLogged(bool value);

  Future<bool> setAccessToken(String value);

  Future<String?> getUserMap();

  Future<bool?> getIsLogged();

  Future<String?> getAccessToken();

  Future<CustomStatusCodeErrorType> getIsFirstTime();

  Future<bool> setUserFirstTime(bool value);

  void deleteCachedUser();

  Future<bool> setCachedUser(AuthBaseModel user);

  Future<AuthBaseModel> getCachedUser();
}

class AuthLocalDataSourceImp extends AuthLocalDataSourceInterface {
  @override
  Future<bool> setUserMap(String value) async {
    return SharedPrefs.setString(DbKeys.userMap, value);
  }

  @override
  Future<bool> setIsLogged(bool value) async {
    return SharedPrefs.setBool(DbKeys.isLogged, value);
  }

  @override
  Future<bool> setAccessToken(String value) async {
    return SharedPrefs.setString(DbKeys.token, value);
  }

  @override
  Future<String?> getUserMap() async {
    return SharedPrefs.getString(DbKeys.userMap);
  }

  @override
  Future<bool?> getIsLogged() async {
    return SharedPrefs.getBool(DbKeys.isLogged);
  }

  @override
  Future<String?> getAccessToken() async {
    return SharedPrefs.getString(DbKeys.token);
  }

  @override
  Future<bool> setUserFirstTime(bool value) async {
    return SharedPrefs.setBool(DbKeys.firstTime, value);
  }

  @override
  Future<CustomStatusCodeErrorType> getIsFirstTime() async {
    final bool isFirstTime =
        await SharedPrefs.getBool(DbKeys.firstTime) ?? true;

    if (isFirstTime) {
      return CustomStatusCodeErrorType.unVerified;
    } else {
      return CustomStatusCodeErrorType.unExcepted;
    }
  }

  @override
  Future<void> deleteCachedUser() async {
    setAccessToken('');
    setUserMap('');
    setIsLogged(false);
  }

  @override
  Future<bool> setCachedUser(AuthBaseModel user) {
    return setAccessToken(user.token!).then((bool value) {
      return setIsLogged(true).then((bool value) {
        return setUserMap(jsonEncode(user.toJson()));
      });
    });
  }

  @override
  Future<AuthBaseModel> getCachedUser() async {
    final String? userString = await getUserMap();
    final Map<String, dynamic> baseUserMap = json.decode(userString!);
    final AuthBaseModel userModel = AuthBaseModel.fromJson(baseUserMap);
    final String? token = await getAccessToken();
    userModel.token = token;

    return userModel;
  }
}
