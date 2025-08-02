import 'package:base_project_repo/core/error_handling/custom_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/places_model.dart';
import '../../../data/model/places_search_model.dart';
import '../../../domain/use_case/map_use_case.dart';
import 'recommendation_place_cubit_state.dart';

class RecommendationPlaceCubit extends Cubit<RecommendationPlaceState> {
  RecommendationPlaceCubit(this.useCase)
      : super(RecommendationPlaceInitialState());
  final MapSearchUseCase useCase;

  List<PlaceSearch> placeSearchResult = <PlaceSearch>[];
  Place? selectedPlace;

  ///get list of  places prediction
  void getPlacesAutoComplete({required String userInput}) async {
    emit(RecommendationPlaceLoadingState());
    await useCase.getAutocomplete(userInput: userInput).then(
        (Either<CustomException, List<PlaceSearch>> value) => value.fold(
                (CustomException failure) => emit(
                    RecommendationPlaceFailedState(
                        error: failure.errorMassage)),
                (List<PlaceSearch> places) {
              placeSearchResult = places;
              emit(RecommendationPlaceSuccessState());
            }));
  }

  ///get place selected information by place id
  getPlaceInfo({required String placeId}) async {
    emit(RecommendationPlaceLoadingState());
    await useCase
        .getPlace(
          placeId: placeId,
        )
        .then((Either<CustomException, Place> value) => value.fold(
                (CustomException failure) => emit(
                    RecommendationPlaceFailedState(
                        error: failure.errorMassage)), (Place places) {
              selectedPlace = places;
              emit(GetPlaceInfoSuccessState());
            }));
  }
}
