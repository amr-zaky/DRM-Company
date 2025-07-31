import 'location_model.dart';

class Geometry {
  final Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);

  @override
  String toString() {
    return 'Geometry{location: $location}';
  }
}
