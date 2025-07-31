import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/keys/icon_path.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/shared_texts.dart';
import '../common_asset_svg_image_widget.dart';
import '../common_text_form_field_widget.dart';
import '../common_title_text.dart';
import '/core/constants/app_constants.dart';

class PhoneFormWidget extends StatelessWidget {
  const PhoneFormWidget(
      {Key? key,
      required this.phoneController,
      required this.phoneOnChanged,
      this.hintKey,
      this.checkCurrentPhone = false,
      this.isReadOnly = false,
      this.onTap,
      this.phoneValidator})
      : super(key: key);
  final TextEditingController phoneController;
  final String? Function(String?)? phoneOnChanged;
  final String? hintKey;
  final bool checkCurrentPhone;
  final bool? isReadOnly;
  final String? Function(String?)? phoneValidator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: phoneController,
      hintKey: hintKey ?? AppLocalizations.of(context)!.lblPhone,
      keyboardType: TextInputType.phone,
      isReadOnly: isReadOnly,
      onTap: onTap,
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(AppConstants.phoneLength),
      ],
      prefixIcon: Container(
        width: getWidgetWidth(71),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: SharedText.currentLocale == "ar"
                  ? AppConstants.lightGrayColor
                  : AppConstants.transparent,
            ),
            right: BorderSide(
              color: SharedText.currentLocale == "ar"
                  ? AppConstants.transparent
                  : AppConstants.lightGrayColor,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            const CommonAssetSvgImageWidget(
                imageString: IconPath.arabicIcon,
                fit: BoxFit.contain,
                height: 22,
                width: 22),
            getSpaceWidth(AppConstants.padding4),
            const Directionality(
                textDirection: TextDirection.ltr,
                child: CommonTitleText(
                  textKey: "+966",
                  textFontSize: AppConstants.fontSize14,
                  textWeight: FontWeight.w700,
                ))
          ],
        ),
      ),
      validator: phoneValidator ??
          (String? value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.lblPhoneIsEmpty;
            } else if (value.length != AppConstants.phoneLength) {
              return AppLocalizations.of(context)!.lblPhoneValidate;
            } else if (checkCurrentPhone &&
                (value != SharedText.currentUser?.phone!)) {
              return AppLocalizations.of(context)!.lblWrongPhoneNumber;
            } else {
              return null;
            }
          },
      onChanged: phoneOnChanged,
    );
  }
}
