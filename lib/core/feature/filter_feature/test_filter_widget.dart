import 'dart:developer';

import 'package:base_project_repo/core/constants/app_constants.dart';
import 'package:base_project_repo/core/feature/pick_multi_image/domain/model/image_class_model.dart';
import 'package:base_project_repo/core/presentation/widgets/common_global_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/shared_texts.dart';
import '../../presentation/routes/route_argument.dart';
import '../../presentation/routes/route_names.dart';
import '../../presentation/widgets/common_drop_down_menu.dart';
import '../download_pdf/model/document_model.dart';
import '../pick_multi_image/presentation/common_pick_images_widget.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import 'domain/model/search_filter_model.dart';

class TestFilterWidget extends StatefulWidget {
  const TestFilterWidget({super.key});

  @override
  State<TestFilterWidget> createState() => _TestFilterWidgetState();
}

class _TestFilterWidgetState extends State<TestFilterWidget> {
  // this list and function just for testing and showing the function.
  CategoryModel? selectedItem;
  List<ImageModel> images = <ImageModel>[];

  void setImagesValue(List<ImageModel> values) {
    setState(() {
      images = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CommonGlobalButton(
            buttonText: "open pdf",
            onPressedFunction: () {
              context.pushNamed(RouteNames.documentPageRoute,
                  extra: RouteArgument(
                      documentModel: DocumentModel(
                          name: "Contract",
                          originalUrl:
                              "http://185.202.239.86/storage/28/Test-PDF-.pdf",
                          size: 225,
                          extension: "pdf")));
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidgetWidth(16)),
          child: CommonDropdownButton(
            hintText: "select item",
            listOfItems: <SelectableModel>[
              CategoryModel(id: 1, name: "test 1"),
              CategoryModel(id: 2, name: "test 2"),
              CategoryModel(id: 3, name: "test 3"),
              CategoryModel(id: 4, name: "test 4"),
            ],
            dropdownWidth: SharedText.screenWidth - getWidgetWidth(32),
            selectedValue: selectedItem,
            icon: IconPath.settingIcon,
            onChangeValue: (SelectableModel? value) {
              setState(() {
                selectedItem = value as CategoryModel?;
              });
              log("this the selected item $value");
            },
          ),
        ),
        getSpaceHeight(AppConstants.padding16),
        PickImageWidget(
          images: images,
          imageLength: AppConstants.imageMaxLength,
          onSaveImage: (List<ImageModel> images) {
            setImagesValue(images);
          },
        ),
      ],
    );
  }
}

class CategoryModel extends SelectableModel {
  CategoryModel({
    super.id,
    super.name,
  });
}
