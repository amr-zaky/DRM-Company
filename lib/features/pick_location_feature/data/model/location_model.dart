import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng latLong;

  Location({required this.latLong});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Location(latLong: LatLng(parsedJson['lat'], parsedJson['lng']));
  }

  @override
  String toString() {
    return 'Location{lat: ${latLong.latitude}, lng: ${latLong.longitude}}';
  }
}
