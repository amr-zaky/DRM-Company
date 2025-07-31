import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/app_constants.dart';
import '/core/presentation/widgets/common_text_form_field_widget.dart';

class NumberFormWidget extends StatelessWidget {
  const NumberFormWidget(
      {Key? key,
      required this.phoneController,
      required this.phoneOnChanged,
      this.hintKey,
      this.isReadOnly = false,
      this.phoneValidator})
      : super(key: key);
  final TextEditingController phoneController;
  final String? Function(String?)? phoneOnChanged;
  final String? hintKey;
  final bool? isReadOnly;
  final String? Function(String?)? phoneValidator;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: phoneController,
      hintKey: hintKey ?? AppLocalizations.of(context)!.lblPhone,
      keyboardType: const TextInputType.numberWithOptions(),
      isReadOnly: isReadOnly,
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(AppConstants.phoneLength),
      ],
      validator: phoneValidator ??
          (String? value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.lblPhoneIsEmpty;
            } else if (value.length != AppConstants.phoneLength) {
              return AppLocalizations.of(context)!.lblPhoneValidate;
            } else {
              return null;
            }
          },
      onChanged: phoneOnChanged,
    );
  }
}
