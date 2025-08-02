import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:base_project_repo/core/presentation/widgets/common_waiting_dialog_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/custom_snack_bar.dart';
import 'package:base_project_repo/core/presentation/widgets/form_input_widgets/name_form_widget.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/add_address_cubit/add_address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/add_address_cubit/add_address_states.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/address_cubit/address_cubit.dart';
import 'package:base_project_repo/features/pick_location_feature/presentation/logic/google_map_Cubit/google_map_cubit.dart';
import 'package:base_project_repo/features/pick_location_feature/presentation/logic/google_map_Cubit/google_map_states.dart';
import 'package:base_project_repo/features/pick_location_feature/presentation/widget/map_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({
    super.key,
    required this.routeArgument,
  });

  final RouteArgument routeArgument;

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late GoogleMapCubit mapCubit;
  late AddNewAddressCubit addressCubit;

  @override
  void initState() {
    super.initState();
    mapCubit = GoogleMapCubit.get(context);
    addressCubit = AddNewAddressCubit.get(context);
    addressCubit.initCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          centerTitle: false,
          leadingWidth: getWidgetWidth(AppConstants.padding16),
          customTitleWidget: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblAddAddress,
            textWeight: FontWeight.w500,
          ),
        ),
        body: BlocConsumer<AddNewAddressCubit, AddNewAddressStates>(
          listener:
              (BuildContext addressCtx, AddNewAddressStates addressState) {
            if (addressState is AddNewAddressLoadingState) {
              showWaitingDialog(context);
            } else if (addressState is AddNewAddressErrorState) {
              context.pop();
              showSnackBar(
                  context: context, title: addressState.error!.errorMassage);
              checkUserAuth(
                  context: context, errorType: addressState.error!.type);
            } else if (addressState is AddNewAddressSuccessState) {
              context.pop();
              context.pop();
              widget.routeArgument.onAddressSuccess!();
            }
          },
          builder: (BuildContext context, AddNewAddressStates state) {
            return BlocConsumer<GoogleMapCubit, GoogleMapState>(
              listener: (BuildContext mapCtx, GoogleMapState mapState) {},
              builder: (BuildContext mapCtx, GoogleMapState mapState) {
                return SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.padding16),
                          child: NameFormWidget(
                            nameController: addressCubit.addressNameController,
                            nameOnChanged: (String? nameOnChanged) {
                              return null;
                            },
                            withPrefixIcon: false,
                            validator: (String? nameOnChanged) {
                              return null;
                            },
                            hintText:
                                AppLocalizations.of(context)!.lblAddressName,
                          ),
                        ),
                        MapSearchWidget(onLocationTap: (LatLng point) {
                          mapCubit.setCameraLocation(
                              startPoint: point, cameraZoom: 12);
                        }),

                        ///google map
                        SizedBox(
                          height: getWidgetHeight(530),
                          width: getWidgetWidth(343),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius8,
                            ),
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(30.546162, 30.7841651),
                                zoom: 7,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                mapCtx
                                    .read<GoogleMapCubit>()
                                    .setMapController(controller, context);
                              },
                              markers: mapCubit.destinationMarker == null
                                  ? <Marker>{}
                                  : <Marker>{mapCubit.destinationMarker!},
                              onTap: (LatLng latLong) async {
                                mapCtx.read<GoogleMapCubit>().setMarkerLocation(
                                    point: latLong,
                                    pointName: 'destination',
                                    imageData:
                                        mapCubit.destinationMarkerImage!);
                              },
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                            ),
                          ),
                        ),
                        getSpaceHeight(AppConstants.padding16),
                        if (mapCubit.locationPickedAddress != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                CommonAssetSvgImageWidget(
                                    imageString: IconPath.locationIcon,
                                    height: 16,
                                    width: 16),
                                getSpaceWidth(AppConstants.padding4),
                                CommonTitleText(
                                    textKey: mapCubit.locationPickedAddress!),
                              ],
                            ),
                          ),
                        getSpaceHeight(AppConstants.padding16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: CommonGlobalButton(
                            buttonBackgroundColor: AppConstants.mainTextColor,
                            onPressedFunction: () {
                              if (mapCubit.destinationLocation == null) {
                                showSnackBar(
                                    context: context,
                                    title: AppLocalizations.of(context)!
                                        .lblYouMustPickALocation);
                                return;
                              }
                              if (addressCubit
                                  .addressNameController.text.isEmpty) {
                                showSnackBar(
                                    context: context,
                                    title: AppLocalizations.of(context)!
                                        .lblAddressNameIsEmpty);
                                return;
                              }
                              if (mapCubit.destinationLocation != null) {
                                addressCubit.addNewAddress(
                                    lat: mapCubit.destinationLocation!.latitude,
                                    lng:
                                        mapCubit.destinationLocation!.longitude,
                                    fullDescription:
                                        mapCubit.locationPickedAddress ??
                                            addressCubit
                                                .addressNameController.text);
                              }
                            },
                            buttonText:
                                AppLocalizations.of(context)!.lblPickLocation,
                            icon: Icon(
                              Icons.location_on_outlined,
                              color:
                                  AppConstants.lightWhiteColor.withOpacity(0.6),
                            ),
                          ),
                        ),

                        /// search in map
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
