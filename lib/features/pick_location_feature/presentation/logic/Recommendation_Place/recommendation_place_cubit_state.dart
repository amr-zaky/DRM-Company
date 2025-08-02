abstract class RecommendationPlaceState {}

///initial state for the recommendation place
class RecommendationPlaceInitialState extends RecommendationPlaceState {}

///loading places
class RecommendationPlaceLoadingState extends RecommendationPlaceState {}

///places calling and parsing success
class RecommendationPlaceSuccessState extends RecommendationPlaceState {
}

/// user tap on one of the places camera should change zoom and angle (if needed to show the place on map)
class GetPlaceInfoSuccessState extends RecommendationPlaceState {}

///error in getting or parsing the places
class RecommendationPlaceFailedState extends RecommendationPlaceState {
  String? error;

  RecommendationPlaceFailedState({this.error});
}
