import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/shared_texts.dart';
import '../../../presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../presentation/widgets/common_empty_widget.dart';
import '../../../presentation/widgets/common_global_button.dart';
import '../../../presentation/widgets/common_text_form_field_widget.dart';
import '../../../presentation/widgets/common_title_text.dart';
import '../domain/model/search_filter_model.dart';
import '/core/constants/keys/icon_path.dart';
import 'logic/search_filter_cubit/search_filter_cubit.dart';
import 'logic/search_filter_cubit/search_filter_states.dart';
import 'select_multi_item.dart';
import 'select_single_item.dart';

/// Displays a modal popup for advanced search with options.
Future<void> advancedSearchPopUP({
  required BuildContext context,
  required String title,
  required Function(dynamic) onApply,
  required List<SelectableModel> listOfItem,
  SelectableModel? selectedModel,
  List<SelectableModel>? multiSelectData,
  bool isMultiSelect = false,
  bool isListHaveSearch = true,
  double heightFactor = 0.75,
  bool withImage = false,
}) async {
  final AllFilterCubit allFilterCubit = AllFilterCubit.get(context);
  allFilterCubit.setList(listOfItem);
  if (isMultiSelect) {
    allFilterCubit.setMultiModelData(multiSelectData??[]);
  } else {
    if (multiSelectData != null) {
      allFilterCubit.setModelSingleSelect(multiSelectData.first);
    }
  }
  allFilterCubit.setModelSingleSelect(selectedModel);

  showModalBottomSheet(
    context: context,
    backgroundColor: AppConstants.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) => FractionallySizedBox(
      heightFactor: heightFactor,
      child: Container(
          decoration: const BoxDecoration(
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.borderRadius18),
              topLeft: Radius.circular(AppConstants.borderRadius24),
            ),
          ),
          child: BlocConsumer<AllFilterCubit, AllFilterCubitState>(
            listener:
                (BuildContext filterCtx, AllFilterCubitState filterState) {},
            builder: (BuildContext filterCtx, AllFilterCubitState filterState) {
              return InkWell(
                onTap: () => hideKeyboard(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getSpaceHeight(AppConstants.padding24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CommonTitleText(
                            textKey: title,
                            textWeight: FontWeight.w500,
                            textColor: AppConstants.mainColor,
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const CommonAssetSvgImageWidget(
                              imageString: IconPath.closeIcon,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ],
                      ),
                      getSpaceHeight(AppConstants.padding16),
                      if (isListHaveSearch) ...<Widget>[
                        CommonTextFormField(
                          hintKey: AppLocalizations.of(context)!.lblSearchHere,
                          onChanged: (String? val) {
                            filterCtx.read<AllFilterCubit>().searchInList(val!);
                            return null;
                          },
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: CommonAssetSvgImageWidget(
                              imageColor: AppConstants.mainColor,
                              imageString: IconPath.searchIcon,
                              height: 15,
                              width: 15,
                            ),
                          ),
                        ),
                        getSpaceHeight(AppConstants.padding16),
                      ],
                      if (filterCtx
                          .read<AllFilterCubit>()
                          .listOfModelsTemp
                          .isEmpty) ...<Widget>[
                        EmptyScreen(
                          imageString: IconPath.emptyIcon,
                          titleKey:
                              AppLocalizations.of(context)!.lblNoResultFount,
                          description:
                              AppLocalizations.of(context)!.lblAdjustYourSearch,
                          imageHeight: 120,
                          imageWidth: 120,
                        ),
                      ] else ...<Widget>[
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final SelectableModel model = filterCtx
                                  .read<AllFilterCubit>()
                                  .listOfModelsTemp[index];
                              return InkWell(
                                onTap: () {
                                  if (isMultiSelect) {
                                    filterCtx
                                        .read<AllFilterCubit>()
                                        .setModelMultiSelect(model);
                                  } else {
                                    filterCtx
                                        .read<AllFilterCubit>()
                                        .setModelSingleSelect(model);
                                  }
                                },
                                child: isMultiSelect
                                    ? PopUpMultiItem(
                                        model: model,
                                        isSelected: filterCtx
                                            .read<AllFilterCubit>()
                                            .isModelSelected(
                                              model,
                                              isMultiSelect,
                                            ),
                                      )
                                    : PopUpSingleItem(
                                        model: model,
                                        withImage: withImage,
                                        isSelected: filterCtx
                                            .read<AllFilterCubit>()
                                            .isModelSelected(
                                              model,
                                              isMultiSelect,
                                            ),
                                      ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                getSpaceHeight(AppConstants.padding8),
                            itemCount: filterCtx
                                .read<AllFilterCubit>()
                                .listOfModelsTemp
                                .length,
                          ),
                        ),
                        CommonGlobalButton(
                            buttonText:
                                AppLocalizations.of(context)!.lblConfirm,buttonBackgroundColor: AppConstants.mainTextColor,
                            onPressedFunction: () {
                              if (isMultiSelect) {
                                onApply(allFilterCubit.listOfSelectedModelItem);
                              } else {
                                onApply(allFilterCubit.modelItem);
                              }
                              context.pop();
                            }),
                      ],
                      getSpaceHeight(SharedText.screenHeight * 0.05)
                    ],
                  ),
                ),
              );
            },
          )),
    ),
  );
}
