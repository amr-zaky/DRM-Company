import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';
import 'package:image_picker/image_picker.dart';

class AuthEntity {
  AuthEntity(
      {this.name,
      this.email,
      this.phone,
      this.newPhone,
      this.userCredential,
      this.active,
      this.verified,
      this.id,
      this.image,
      this.imageXFile,
      this.otp,
      this.deviceToken,
      this.token,
      this.confirmPassword,
      this.newPassword,
      this.idCardNumber,
      this.password,
      this.companyNumber,
      this.taxNumber,
      this.products});

  int? id;
  String? name;
  String? userCredential;
  String? email;
  String? phone;
  String? newPhone;
  int? active;
  int? verified;
  String? image;
  String? otp;
  String? deviceToken;
  String? token;
  String? password;
  String? newPassword;
  String? confirmPassword;
  String? idCardNumber;
  String? companyNumber;
  String? taxNumber;
  XFile? imageXFile;
  List<SelectableModel>? products;

  @override
  String toString() {
    return '''AuthBaseEntity{id: $id, name: $name,
     userCredential: $userCredential, email: $email, 
     phone: $phone, active: $active, verified: $verified,
     image: $image, otp: $otp, deviceToken: $deviceToken,
     token: $token, password: $password, newPassword: $newPassword,
     confirmPassword: $confirmPassword, idCardNumber: $idCardNumber,
      companyNumber: $companyNumber, taxNumber: $taxNumber, imageXFile: $imageXFile
     }''';
  }
}
