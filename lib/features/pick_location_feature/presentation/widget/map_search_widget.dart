import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../data/model/places_search_model.dart';
import '../logic/Recommendation_Place/recommendation_place_cubit.dart';
import '../logic/Recommendation_Place/recommendation_place_cubit_state.dart';

class MapSearchWidget extends StatelessWidget {
  final Function(LatLng startPoint) onLocationTap;

  const MapSearchWidget({Key? key, required this.onLocationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendationPlaceCubit, RecommendationPlaceState>(
      listener: (BuildContext recommendationPlaceCtx,
          RecommendationPlaceState recommendationPlaceState) {
        if (recommendationPlaceState is GetPlaceInfoSuccessState) {
          onLocationTap(recommendationPlaceCtx
              .read<RecommendationPlaceCubit>()
              .selectedPlace!
              .geometry!
              .location!
              .latLong);
        }
      },
      builder: (BuildContext recommendationPlaceCtx,
          RecommendationPlaceState recommendationPlaceState) {
        return Autocomplete<PlaceSearch>(
          displayStringForOption: (PlaceSearch option) => option.description!,
          optionsMaxHeight: getWidgetHeight(150),
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return CommonTextFormField(
              controller: fieldTextEditingController,
              hintKey: "Search",
              fieldHeight: getWidgetHeight(55),
              fieldWidth: getWidgetWidth(343),
              radius: 12,
              fieldFocusNode: fieldFocusNode,
              prefixIcon: const Icon(
                Icons.search,
                color: AppConstants.lightBlackColor,
                size: 14,
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<PlaceSearch> onSelected,
              Iterable<PlaceSearch> options) {
            return Align(
              alignment: SharedText.currentLocale == "ar"
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Material(
                color: AppConstants.transparent,
                child: Container(
                  width: getWidgetWidth(343),
                  decoration: BoxDecoration(
                      color: AppConstants.lightWhiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: AppConstants.greyColor,
                        height: 1,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final PlaceSearch option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CommonTitleText(
                            textKey: option.description!,
                            textColor: AppConstants.mainColor,
                            textFontSize: AppConstants.fontSize14,
                            textAlignment: TextAlign.start,
                            lines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '' ||
                textEditingValue.text.isEmpty) {
              return const Iterable<PlaceSearch>.empty();
            } else {
              recommendationPlaceCtx
                  .read<RecommendationPlaceCubit>()
                  .getPlacesAutoComplete(userInput: textEditingValue.text);
              return recommendationPlaceCtx
                  .read<RecommendationPlaceCubit>()
                  .placeSearchResult;
            }
          },
          onSelected: (PlaceSearch selection) {
            recommendationPlaceCtx
                .read<RecommendationPlaceCubit>()
                .getPlaceInfo(
                  placeId: selection.placeId!,
                );
            hideKeyboard(context);
          },
        );
      },
    );
  }
}
