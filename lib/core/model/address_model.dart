import 'package:base_project_repo/core/feature/filter_feature/domain/model/search_filter_model.dart';

import '../constants/enums/exception_enums.dart';
import '../error_handling/custom_exception.dart';

List<AddressModel> addressListFromJson(List<dynamic> str) =>
    List<AddressModel>.from(str.map((dynamic x) => AddressModel.fromJson(x)));

class AddressModel extends SelectableModel {
  AddressModel({
    super.id,
    super.name,
    this.lat,
    this.lng,
    this.isDefault,
    this.location,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    try {
      return AddressModel(
          id: json['id'],
          name: json["name"],
          lat: json["lat"],
          lng: json["lng"],
          location: json["location"],
          isDefault: json["is_default"] == 1);
    } catch (ex) {
      throw CustomException(CustomStatusCodeErrorType.parsing,
          errorMassage: "AddressModel error in Parsing: ${ex.toString()}");
    }
  }

  num? lat;
  num? lng;
  bool? isDefault;
  String? location;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id.toString(),
        "name": name,
        "lat": lat,
        "lng": lng,
        "isDefault": isDefault,
      };
}
