import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../feature/filter_feature/domain/model/search_filter_model.dart';
import '../../helpers/shared.dart';
import '../../helpers/shared_texts.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_title_text.dart';

class CommonDropdownButton extends StatefulWidget {
  const CommonDropdownButton({
    Key? key,
    required this.onChangeValue,
    this.selectedValue,
    required this.listOfItems,
    this.icon,
    this.dropdownWidth,
    required this.hintText,
  }) : super(key: key);
  final Function(SelectableModel?) onChangeValue;
  final SelectableModel? selectedValue;
  final List<SelectableModel> listOfItems;
  final String? icon;
  final String hintText;
  final double? dropdownWidth;

  @override
  State<CommonDropdownButton> createState() => _CommonDropdownButtonState();
}

class _CommonDropdownButtonState extends State<CommonDropdownButton> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<SelectableModel>(
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        elevation: 1,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(AppConstants.borderRadius8),
              bottomLeft: Radius.circular(AppConstants.borderRadius8)),
          color: AppConstants.lightWhiteColor,
        ),
        width: widget.dropdownWidth ?? SharedText.screenWidth,
      ),
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
          border:
              Border.all(color: AppConstants.borderInputColor.withOpacity(0.5)),
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(AppConstants.borderRadius8),
              topRight: const Radius.circular(AppConstants.borderRadius8),
              bottomRight: Radius.circular(
                  isExpanded ? 0.0 : AppConstants.borderRadius8),
              bottomLeft: Radius.circular(
                  isExpanded ? 0.0 : AppConstants.borderRadius8)),
          color: AppConstants.lightWhiteColor,
        ),
        height: getWidgetHeight(48),
        padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(AppConstants.padding16),
        ),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: AppConstants.mainColor,
        ),
        iconEnabledColor: AppConstants.lightRedColor,
      ),
      isDense: true,
      isExpanded: true,
      onMenuStateChange: (bool value) {
        setState(() {
          isExpanded = value;
        });
      },
      items: widget.listOfItems.map((SelectableModel item) {
        return DropdownMenuItem<SelectableModel>(
          value: item,
          child: Container(
            margin: EdgeInsets.zero,
            width: SharedText.screenWidth,
            decoration: const BoxDecoration(
                color: AppConstants.lightWhiteColor,
                border: Border(
                    bottom: BorderSide(
                        color: AppConstants.borderInputColor, width: 0.0))),
            child: CommonTitleText(
              textKey: item.name!,
              textColor: AppConstants.mainColor,
            ),
          ),
        );
      }).toList(),
      underline: const SizedBox(),
      onChanged: widget.onChangeValue,
      hint: widget.selectedValue != null
          ? selectedItem(widget.selectedValue!.name ?? "---")
          : selectedItem(widget.hintText),
    );
  }

  Widget selectedItem(String obj) {
    return Row(
      children: <Widget>[
        if (widget.icon != null) ...<Widget>[
          CommonAssetSvgImageWidget(
            imageString: widget.icon!,
            height: 24,
            width: 24,
          ),

          /// Spacer
          getSpaceWidth(AppConstants.padding16),
        ],
        CommonTitleText(
          textKey: obj,
          textColor: AppConstants.mainColor,
        ),
      ],
    );
  }
}
