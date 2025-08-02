import 'geometry.dart';

List<Place> placeListFromJson(List str) =>
    List<Place>.from(str.map((x) => Place.fromJson(x)));
class Place {
  final Geometry? geometry;
  final String? name;
  final String? vicinity;

  Place({this.geometry, this.name, this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }

  @override
  String toString() {
    return 'Place{geometry: $geometry, name: $name, vicinity: $vicinity}';
  }
}
