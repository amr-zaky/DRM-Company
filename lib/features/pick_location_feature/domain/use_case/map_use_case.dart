import 'package:base_project_repo/core/error_handling/custom_exception.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/places_model.dart';
import '../../data/model/places_search_model.dart';
import '../interface/map_places_interface.dart';

class MapSearchUseCase {
  MapSearchUseCase(this._repo);

  final MapPlacesInterface _repo;

  ///get list of  places prediction
  Future<Either<CustomException, List<PlaceSearch>>> getAutocomplete(
      {required String userInput}) async {
    return _repo.getAutocomplete(search: userInput);
  }

  ///get place selected information by place id
  Future<Either<CustomException, Place>> getPlace(
      {required String placeId}) async {
    return _repo.getPlace(placeId: placeId);
  }
}
