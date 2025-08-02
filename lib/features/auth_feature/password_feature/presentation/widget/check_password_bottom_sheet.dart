import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/keys/icon_path.dart';
import '../../../../../core/helpers/shared.dart';
import '../../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../../core/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';
import '/core/constants/enums/exception_enums.dart';

class CheckPasswordBottomSheet extends StatefulWidget {
  const CheckPasswordBottomSheet(
      {super.key,
      required this.phone,
      required this.onPasswordChecked,
      required this.isEnable});

  final String phone;
  final Function(String password) onPasswordChecked;
  final bool isEnable;

  @override
  State<CheckPasswordBottomSheet> createState() =>
      _CheckPasswordBottomSheetState();
}

class _CheckPasswordBottomSheetState extends State<CheckPasswordBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PasswordCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = PasswordCubit.get(context);
    cubit.initialController();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.disposeController();
  }

  @override
  Widget build(BuildContext context) {
    return CommonGlobalButton(
      buttonText: AppLocalizations.of(context)!.lblSaveChanges,
      buttonBackgroundColor: AppConstants.appBarTitleColor,

      radius: AppConstants.borderRadius8,
      onPressedFunction: () {
        showBottomModalSheet(
          context: context,
          children: <Widget>[
            GestureDetector(
              onTap: () => hideKeyboard(context),
              child: BlocConsumer<PasswordCubit, PasswordStates>(
                listener: (BuildContext context, PasswordStates state) {
                  if (state is CheckPasswordSuccessState) {
                    context.pop();
                    widget.onPasswordChecked(cubit.passwordController.text);
                  } else if (state is CheckPasswordFailedState) {
                    showSnackBar(
                        context: context,
                        title: state.error.type.getErrorMessage(context) ??
                            state.error.errorMassage,
                        color: AppConstants.lightRedColor);
                  }
                },
                builder: (BuildContext context, PasswordStates state) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                            horizontal:
                                getWidgetHeight(AppConstants.padding16)) +
                        EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          getSpaceHeight(AppConstants.padding8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CommonTitleText(
                                  textKey: AppLocalizations.of(context)!
                                      .lblChangeNumber,
                                  minTextFontSize: AppConstants.fontSize16,
                                  textWeight: FontWeight.w500,
                                  textColor: AppConstants.mainColor),
                              InkWell(
                                onTap: () => context.pop(),
                                child: const CommonAssetSvgImageWidget(
                                    imageString: IconPath.closeIcon,
                                    height: 16,
                                    width: 16),
                              ),
                            ],
                          ),
                          getSpaceHeight(AppConstants.padding16),

                          /// Title
                          Row(
                            children: <Widget>[
                              CommonTitleText(
                                  textKey: AppLocalizations.of(context)!
                                      .lblToConfirmChangingPhone,
                                  textFontSize: AppConstants.fontSize12,
                                  minTextFontSize: AppConstants.fontSize12,
                                  textWeight: FontWeight.w500,
                                  textColor: AppConstants.lightGreyColor),
                              CommonTitleText(
                                  textKey: widget.phone,
                                  textFontSize: AppConstants.fontSize12,
                                  minTextFontSize: AppConstants.fontSize12,
                                  textWeight: FontWeight.w600),
                            ],
                          ),
                          getSpaceHeight(8),

                          /// SubTitle
                          Row(
                            children: <Widget>[
                              CommonTitleText(
                                  textKey: AppLocalizations.of(context)!
                                      .lblEnterPasswordForAccount,
                                  textFontSize: AppConstants.fontSize12,
                                  minTextFontSize: AppConstants.fontSize12,
                                  textWeight: FontWeight.w500,
                                  textColor: AppConstants.lightGreyColor),
                            ],
                          ),
                          getSpaceHeight(16),

                          /// Password TextField
                          PasswordFormWidget(
                            passwordController: cubit.passwordController,
                            passwordOnChanged: (String? value) {
                              cubit.checkPasswordFieldValid(value!);
                              return value;
                            },
                            onSuffixTap: () {
                              cubit.toggleHidePassword();
                            },
                            showPasswordText: cubit.hidePassword,
                          ),
                          getSpaceHeight(60),

                          /// Button
                          Center(
                            child: CommonGlobalButton(
                              buttonText:
                                  AppLocalizations.of(context)!.lblConfirm,
                              buttonBackgroundColor:
                                  AppConstants.appBarTitleColor,
                              radius: AppConstants.borderRadius8,
                              onPressedFunction: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.checkPassword();
                                }
                              },
                              isEnable:
                                  cubit.passwordController.text.isNotEmpty,
                              isLoading: state is CheckPasswordLoadingState,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      isEnable: widget.isEnable,
    );
  }
}
