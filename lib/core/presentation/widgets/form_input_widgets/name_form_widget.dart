import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/keys/icon_path.dart';
import '../../../helpers/validators/validators.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_text_form_field_widget.dart';

class NameFormWidget extends StatelessWidget {
  const NameFormWidget({
    Key? key,
    required this.nameController,
    required this.nameOnChanged,
    this.validator,
    this.hintText,
    this.withPrefixIcon = true,
  }) : super(key: key);
  final TextEditingController nameController;
  final String? hintText;
  final String? Function(String?)? nameOnChanged;
  final String? Function(String?)? validator;
  final bool withPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: nameController,
      hintKey: hintText ?? AppLocalizations.of(context)!.lblName,
      keyboardType: TextInputType.text,
      prefixIcon: withPrefixIcon
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: CommonAssetSvgImageWidget(
                  imageString: IconPath.userIcon,
                  fit: BoxFit.contain,
                  height: 16,
                  width: 16),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SizedBox.shrink(),
            ),
      validator: validator ??
          (String? value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.lblNameIsEmpty;
            } else if (nameValidator(value)) {
              return AppLocalizations.of(context)!.lblNameBadFormat;
            } else if (value.length < 2) {
              return AppLocalizations.of(context)!.lblNameLength;
            } else {
              return null;
            }
          },
      onChanged: nameOnChanged,
    );
  }
}
