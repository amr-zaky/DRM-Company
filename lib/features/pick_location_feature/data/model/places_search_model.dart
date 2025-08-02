import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/error_handling/custom_exception.dart';

List<PlaceSearch> placeSearchListFromJson(List str) =>
    List<PlaceSearch>.from(str.map((x) => PlaceSearch.fromJson(x)));

class PlaceSearch {
  final String? description;
  final String? placeId;

  PlaceSearch({this.description, this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    try {
      return PlaceSearch(
          description: json['description'], placeId: json['place_id']);
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.parsing,
          errorMassage: 'error when parse place search model');
    }
  }

  @override
  String toString() {
    return 'PlaceSearch{description: $description, placeId: $placeId}';
  }
}
