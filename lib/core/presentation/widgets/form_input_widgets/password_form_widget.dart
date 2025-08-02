import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/keys/icon_path.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/validators/validators.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_text_form_field_widget.dart';

class PasswordFormWidget extends StatelessWidget {
  const PasswordFormWidget({
    Key? key,
    required this.passwordController,
    required this.passwordOnChanged,
    this.passwordValidator,
    this.onSuffixTap,
    this.showPasswordText = true,
    this.hintText,
  }) : super(key: key);
  final TextEditingController passwordController;
  final String? Function(String?)? passwordOnChanged;
  final String? Function(String?)? passwordValidator;
  final Function()? onSuffixTap;
  final bool? showPasswordText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: passwordController,
      suffixIcon: onSuffixTap == null
          ? null
          : GestureDetector(
              onTap: onSuffixTap,
              child: SizedBox(
                width: getWidgetWidth(30),
                height: getWidgetHeight(30),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: CommonAssetSvgImageWidget(
                          imageString: showPasswordText!
                              ? IconPath.eyeCloseIcon
                              : IconPath.eyeOpenIcon,
                          height: 20,
                          width: 20,
                          imageColor: AppConstants.borderInputColor,
                          fit: BoxFit.contain)),
                ),
              ),
            ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      isObscureText: showPasswordText!,
      hintKey: hintText ?? AppLocalizations.of(context)!.lblPassword,
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
            imageString: IconPath.lockIconIcon,
            fit: BoxFit.contain,
            height: 20,
            width: 20),
      ),
      validator: passwordValidator ??
          (String? value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.lblPasswordIsEmpty;
            } else if (value.length < AppConstants.passwordMinLength) {
              return AppLocalizations.of(context)!.lblPasswordMustBeMoreThan;
            } else if (complexValidationLowerAndUpperCaseValidator(value)) {
              return AppLocalizations.of(context)!
                  .lblComplexPasswordValidationUpperAndLower;
            } else {
              return null;
            }
          },
      onChanged: passwordOnChanged,
    );
  }
}
