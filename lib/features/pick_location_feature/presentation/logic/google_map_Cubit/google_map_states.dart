
abstract class GoogleMapState {}

class MapCubitInitialState extends GoogleMapState {}

class MapCubitControllerInitialState extends GoogleMapState {}

class MapCubitControllerDisposeState extends GoogleMapState {}

class MapCubitLoadingState extends GoogleMapState {}

class MapCubitErrorState extends GoogleMapState {
  String massage;

  MapCubitErrorState({required this.massage});
}

class MapCubitSuccessState extends GoogleMapState {}
