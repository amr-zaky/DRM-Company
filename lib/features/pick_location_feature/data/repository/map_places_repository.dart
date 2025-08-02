import 'package:base_project_repo/core/error_handling/custom_exception.dart';
import 'package:base_project_repo/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/custom_error.dart';
import '../../domain/interface/map_places_interface.dart';
import '../data_source/remote_data_source.dart';
import '../model/places_model.dart';
import '../model/places_search_model.dart';

class PlacesRepository extends MapPlacesInterface {
  PlacesRepository(this.mapRemoteDataSource);

  final MapRemoteDataSourceInterface mapRemoteDataSource;

  @override
  Future<Either<CustomException, List<PlaceSearch>>> getAutocomplete(
      {required String search}) async {

    final Either<CustomException, BaseModel> result =
        await mapRemoteDataSource.getAutocomplete(search: search);

    return result.fold((CustomException failure) {
      return left(failure);
    }, (BaseModel result) {
      return right(placeSearchListFromJson(result.data));
    });
  }

  @override
  Future<Either<CustomException, Place>> getPlace(
      {required String placeId}) async {
    final Either<CustomException, BaseModel> result =
        await mapRemoteDataSource.getPlace(
      placeId: placeId,
    );
    return result.fold((CustomException failure) {
      return left(failure);
    }, (BaseModel result) {
      return right(Place.fromJson(result.data));
    });
  }
}
