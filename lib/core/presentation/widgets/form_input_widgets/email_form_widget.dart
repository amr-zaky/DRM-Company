import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/keys/icon_path.dart';
import '../../../helpers/validators/validators.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_text_form_field_widget.dart';

class EmailFormWidget extends StatelessWidget {
  const EmailFormWidget({
    Key? key,
    required this.emailController,
    required this.emailOnChanged,
  }) : super(key: key);
  final TextEditingController emailController;
  final String? Function(String?)? emailOnChanged;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: emailController,
      hintKey: AppLocalizations.of(context)!.lblEmail,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
            imageString: IconPath.emailIcon,
            fit: BoxFit.contain,
            height: 16,
            width: 16),
      ),
      validator: (String? value) {
        if (!validateEmail(value!)) {
          return AppLocalizations.of(context)!.lblEmailBadFormat;
        } else {
          return null;
        }
      },
      onChanged: emailOnChanged,
    );
  }
}
