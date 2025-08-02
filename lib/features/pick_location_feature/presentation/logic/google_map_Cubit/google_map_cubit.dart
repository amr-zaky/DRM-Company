import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/constants/keys/icon_path.dart';
import 'google_map_states.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(MapCubitInitialState());

  static GoogleMapCubit get(context) => BlocProvider.of(context);

  ///map controller
  late GoogleMapController _mapController;

  ///destination properties
  LatLng? destinationLocation;
  Marker? destinationMarker;
  Uint8List? destinationMarkerImage;
  String? locationPickedAddress;

  setMapController(GoogleMapController controller, BuildContext context) {
    _mapController = controller;
    _getMarkersImage(context);

    emit(MapCubitControllerInitialState());
  }

  ///set camera bound based on specific point [startPoint]
  setCameraLocation({required LatLng startPoint, double cameraZoom = 17.00}) {
    emit(MapCubitLoadingState());

    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(startPoint.latitude, startPoint.longitude),
        zoom: cameraZoom)));

    emit(MapCubitSuccessState());
  }

  ///set marker location
  setMarkerLocation({
    double? heading,
    required LatLng point,
    required String pointName,
    required Uint8List imageData,
  }) async {
    emit(MapCubitLoadingState());

    destinationLocation = point;

    destinationMarker = Marker(
        markerId: MarkerId(pointName),
        position: point,
        draggable: false,
        rotation: heading ?? 0,
        zIndex: 1,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData));

    setCameraLocation(startPoint: point, cameraZoom: 15);
    getPlaceAddress(point.latitude, point.longitude);
    emit(MapCubitSuccessState());
  }

  getPlaceAddress(double lat, double lng) async {
    try{
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
      Placemark currentUserPlaceMark = placeMarks[0];

      locationPickedAddress =
      '${currentUserPlaceMark.name!}, ${currentUserPlaceMark.locality!}, ${currentUserPlaceMark.administrativeArea!}';
      emit(MapCubitSuccessState());
    }catch(e){
      locationPickedAddress = null;
    }
  }

  disposeController() {
    _mapController.dispose();
    emit(MapCubitControllerDisposeState());
  }

  ///load marker image
  void _getMarkersImage(context) async {
    ByteData stoppageIconData =
        await rootBundle.load('assets/images/${IconPath.locationPinIcon}');
    ui.Codec codecStoppage = await ui.instantiateImageCodec(
        stoppageIconData.buffer.asUint8List(),
        targetWidth: 90);
    ui.FrameInfo fiStoppage = await codecStoppage.getNextFrame();
    destinationMarkerImage =
        (await fiStoppage.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
  }
}
