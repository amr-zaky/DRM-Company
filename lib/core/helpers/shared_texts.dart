import '../model/auth_base_model.dart';
import 'responsive_ui/device_info.dart';

class SharedText {
  factory SharedText() {
    return _singleton;
  }

  SharedText._internal();
  static final SharedText _singleton = SharedText._internal();

  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static DeviceInfo? deviceType;

  static String currentLocale = 'en';
  static String userToken = '';
  static String deviceToken = 'token';
  static bool isGuestMode = false;
  static AuthBaseModel? currentUser =
      AuthBaseModel(name: "Ahmed Mostafa", phone: "01092936334", image: "");
}
