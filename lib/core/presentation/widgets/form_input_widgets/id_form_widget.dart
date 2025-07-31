import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/keys/icon_path.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_text_form_field_widget.dart';

class IDFormWidget extends StatelessWidget {
  const IDFormWidget({
    Key? key,
    required this.iDController,
    required this.iDOnChanged,
    this.hintKey,
  }) : super(key: key);
  final TextEditingController iDController;
  final String? Function(String?)? iDOnChanged;
  final String? hintKey;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: iDController,
      hintKey: hintKey ?? AppLocalizations.of(context)!.lblIDNumber,
      keyboardType: TextInputType.number,
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(AppConstants.idLength),
      ],
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
            imageString: IconPath.idIcon,
            fit: BoxFit.contain,
            height: 22,
            width: 22),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.lblIdIsEmpty;
        } else if (value.length != AppConstants.idLength) {
          return AppLocalizations.of(context)!.lblIDValidate;
        } else {
          return null;
        }
      },
      onChanged: iDOnChanged,
    );
  }
}
