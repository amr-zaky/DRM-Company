import 'package:flutter/material.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/extensions/format_date_time_to_time_only.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_text_form_field_widget.dart';

class DateFormWidget extends StatefulWidget {
  const DateFormWidget({
    Key? key,
    required this.dateController,
    required this.dateOnChanged,
    required this.validator,
    this.selectedDate,
    required this.title,
    this.enable = true,
    this.firstDate,
  }) : super(key: key);
  final TextEditingController dateController;
  final String? Function(String?)? dateOnChanged;
  final String? Function(String?)? validator;
  final String title;
  final Function(DateTime)? selectedDate;
  final bool enable;
  final DateTime? firstDate;

  @override
  State<DateFormWidget> createState() => _DateFormWidgetState();
}

class _DateFormWidgetState extends State<DateFormWidget> {
  DateTime selectedTime = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppConstants.mainColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppConstants.mainColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: widget.firstDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 90,
        ),
      ),
      selectableDayPredicate: (DateTime date) {
        // Block Fridays (weekday == 5)
        // return date.weekday != DateTime.friday;
        return true;
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        widget.selectedDate!(selectedTime);
        widget.dateController.text = selectedTime.formatDate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConstants.shadowColor,
            blurRadius: 4,
          ),
        ],
      ),
      child: CommonTextFormField(
        controller: widget.dateController,
        hintKey: widget.title,
        radius: AppConstants.padding4,
        filledColor: widget.enable
            ? AppConstants.lightWhiteColor
            : AppConstants.lightGrayOffTwoColor,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.padding12,
            horizontal: AppConstants.padding8,
          ),
          child: CommonAssetSvgImageWidget(
            imageString: IconPath.dateTimeIcon,
            height: 16,
            width: 16,
            imageColor: widget.enable
                ? AppConstants.lightBlackColor
                : AppConstants.lightGrayOffTwoColor,
            fit: BoxFit.contain,
          ),
        ),
        isReadOnly: true,
        onTap: () async {
          if (widget.enable) {
            await _selectTime(context);
          }
        },
        borderColor: AppConstants.transparent,
        labelHintStyle: widget.enable
            ? AppConstants.lightBlackColor
            : AppConstants.lightGrayOffTwoColor,
        focuseAndErrorColor: widget.enable
            ? AppConstants.transparent
            : AppConstants.lightGrayOffTwoColor,
        keyboardType: TextInputType.datetime,
        validator: widget.validator,
        onChanged: widget.dateOnChanged,
      ),
    );
  }
}
