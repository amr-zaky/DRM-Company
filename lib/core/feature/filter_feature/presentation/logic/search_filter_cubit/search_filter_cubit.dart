import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/search_filter_model.dart';
import 'search_filter_states.dart';

class AllFilterCubit extends Cubit<AllFilterCubitState> {
  AllFilterCubit() : super(FilterStateInitial());

  static AllFilterCubit get(BuildContext context) => BlocProvider.of(context);

  List<SelectableModel> listOfModels = <SelectableModel>[];
  List<SelectableModel> listOfModelsTemp = <SelectableModel>[];
  SelectableModel? modelItem;
  List<SelectableModel> listOfSelectedModelItem = <SelectableModel>[];

  void setModelSingleSelect(SelectableModel? model) {
    modelItem = model;
    emit(FilterSetItemState());
  }

  void setList(List<SelectableModel> list) {
    listOfModels = list;
    listOfModelsTemp = List<SelectableModel>.from(list);
    emit(FilterSetListState());
  }

  void setMultiModelData(List<SelectableModel> list) {
    listOfSelectedModelItem = List<SelectableModel>.from(list);
    emit(FilterSetListState());
  }

  void searchInList(String value) {
    listOfModelsTemp = listOfModels
        .where((SelectableModel element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(FilterSearchState());
  }

  bool isModelSelected(SelectableModel model, bool isMultiSelect) {
    if (isMultiSelect) {
      return listOfSelectedModelItem
          .any((SelectableModel element) => element.id == model.id);
    }
    return modelItem?.id == model.id;
  }

  void setModelMultiSelect(SelectableModel model) {
    final int index = listOfSelectedModelItem
        .indexWhere((SelectableModel element) => element.id == model.id);
    if (index != -1) {
      listOfSelectedModelItem.removeAt(index);
    } else {
      listOfSelectedModelItem.add(model);
    }
    emit(FilterSetItemState());
  }
}
