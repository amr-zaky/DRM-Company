import '../constants/enums/exception_enums.dart';

class CustomException implements Exception {
  CustomException(this.type, {this.errorMassage = ""});
  CustomStatusCodeErrorType type;
  String errorMassage;

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}
