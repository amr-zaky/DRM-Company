import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_constants.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {Key? key,
      this.hintKey,
      this.controller,
      this.keyboardType = TextInputType.name,
      this.onTap,
      this.enabled = true,
      this.isSelected = false,
      this.isObscureText = false,
      this.evaluation = true,
      this.fieldWidth,
      this.fieldHeight,
      this.isDigitOnly = false,
      this.minLines = 1,
      this.maxLines = 4,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.onSaved,
      this.borderColor,
      this.filledColor = AppConstants.lightWhiteColor,
      this.textInputColor = AppConstants.lightBlackColor,
      this.labelHintStyle = AppConstants.lightGrayOffColor,
      this.labelErrorStyle = AppConstants.lightRedColor,
      this.inputFormatter,
      this.isReadOnly = false,
      this.action = TextInputAction.next,
      this.labelHintTextAlign = TextAlign.start,
      this.radius = AppConstants.borderRadius10,
      this.alignMultipleLines = false,
      this.fieldFocusNode,
      this.shadowOffset = const Offset(0, 8),
      this.contentPaddingHorizontal = 23,
      this.contentPaddingVertical = 10.0,
      this.hintFontSize = AppConstants.fontSize14,
      this.focuseAndErrorColor})
      : super(key: key);
  final String? hintKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? textInputColor;
  final Function()? onTap;
  final bool enabled;
  final bool isSelected;
  final bool evaluation;
  final bool isObscureText;
  final bool isDigitOnly;
  final String? Function(String?)? validator;
  final double? fieldWidth;
  final double? fieldHeight;
  final int minLines;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? onChanged;
  final Function()? onSaved;
  final Color? borderColor;
  final Color? filledColor;
  final Color? labelHintStyle;
  final Color? labelErrorStyle;
  final List<TextInputFormatter>? inputFormatter;
  final bool? isReadOnly;
  final TextInputAction? action;
  final TextAlign? labelHintTextAlign;
  final double? radius;
  final bool? alignMultipleLines;
  final FocusNode? fieldFocusNode;
  final Offset? shadowOffset;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final double hintFontSize;
  final Color? focuseAndErrorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight,
      width: fieldWidth,
      alignment: Alignment.center,
      child: Center(
        child: TextFormField(
          onTap: onTap,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          enabled: enabled,
          onEditingComplete: onSaved,
          keyboardType: keyboardType,
          obscureText: isObscureText,
          onChanged: onChanged,
          readOnly: isReadOnly!,
          textAlign: labelHintTextAlign!,
          focusNode: fieldFocusNode,
          textInputAction: action,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: textInputColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
          inputFormatters: inputFormatter,
          validator: validator,
          cursorColor: AppConstants.mainColor,
          decoration: InputDecoration(
            hintText: hintKey,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: hintFontSize, fontWeight: FontWeight.w400)
                .apply(
                  color: labelHintStyle,
                ),
            alignLabelWithHint: alignMultipleLines,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                  color: focuseAndErrorColor ??
                      borderColor ??
                      AppConstants.lightGrayColor.withOpacity(0.5),
                  width: 0.4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ??
                    borderColor ??
                    AppConstants.lightGrayColor.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? AppConstants.mainColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ??
                    borderColor ??
                    AppConstants.lightGrayColor.withOpacity(0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius!)),
                borderSide: BorderSide(
                    color: focuseAndErrorColor ?? AppConstants.lightRedColor,
                    width: 0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius!)),
                borderSide: BorderSide(
                    color: focuseAndErrorColor ?? AppConstants.lightRedColor)),
            errorStyle: const TextStyle(
              fontSize: AppConstants.fontSize14,
              fontWeight: FontWeight.w500,
            ).apply(
              color: labelErrorStyle,
            ),
            errorMaxLines: 2,
            contentPadding: EdgeInsets.symmetric(
                vertical: contentPaddingVertical!,
                horizontal: contentPaddingHorizontal!),
            fillColor: filledColor,
            isDense: true,
            filled: true,
            prefixIcon: prefixIcon,
            labelStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
                .apply(
                  color: AppConstants.greyColor,
                ),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
