import 'package:base_project_repo/core/error_handling/custom_exception.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/places_model.dart';
import '../../data/model/places_search_model.dart';

abstract class MapPlacesInterface {
  /// Get auto  Places by user input
  Future<Either<CustomException, List<PlaceSearch>>> getAutocomplete(
      {required String search});

  /// Get place selected information
  Future<Either<CustomException, Place>> getPlace({required String placeId});
}
