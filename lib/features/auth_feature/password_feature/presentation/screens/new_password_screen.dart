import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/password_form_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key, required this.routeArgument})
      : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<StatefulWidget> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PasswordCubit passwordCubit;

  @override
  void initState() {
    super.initState();

    passwordCubit = PasswordCubit.get(context);
    passwordCubit.initialController();
  }

  @override
  void dispose() {
    passwordCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblPassword,
      ),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (BuildContext passwordCtx, PasswordStates passwordStates) {
          if (passwordStates is ChangePasswordStateSuccess) {
            showSnackBar(
                context: context,
                title: AppLocalizations.of(context)!.lblNewPasswordSet,
                color: AppConstants.successColor);
            context.pushReplacementNamed(
              RouteNames.loginHomePageRoute,
            );
          }
          if (passwordStates is ChangePasswordStateError) {
            showSnackBar(
              context: passwordCtx,
              title: passwordStates.error!.type.getErrorMessage(context) ??
                  passwordStates.error!.errorMassage,
            );
          }
        },
        builder: (BuildContext passwordCtx, PasswordStates passwordStates) {
          return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                hideKeyboard(context);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                          horizontal: getWidgetWidth(AppConstants.padding16)) +
                      EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        const CommonAssetSvgImageWidget(
                            imageString: IconPath.forgetPasswordIcon,
                            height: 125,
                            width: 210,
                            fit: BoxFit.contain),

                        getSpaceHeight(AppConstants.padding24),

                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!
                              .lblCreateNewPassword,
                          textFontSize: AppConstants.fontSize20,
                          textWeight: FontWeight.w500,
                        ),
                        getSpaceHeight(AppConstants.padding24),

                        /// Password
                        PasswordFormWidget(
                          passwordController: passwordCubit.passwordController,
                          onSuffixTap: passwordCubit.toggleHidePassword,
                          showPasswordText: passwordCubit.hidePassword,
                          passwordOnChanged: (String? value) {
                            passwordCubit.checkPasswordFieldValid(value!);

                            return value;
                          },
                        ),

                        getSpaceHeight(AppConstants.padding16),

                        /// Confirm Password
                        PasswordFormWidget(
                          hintText:
                              AppLocalizations.of(context)!.lblConfirmPassword,
                          passwordController:
                              passwordCubit.confirmPasswordController,
                          onSuffixTap: passwordCubit.toggleConfirmPassword,
                          showPasswordText: passwordCubit.hideConfirmPassword,
                          passwordValidator: (String? value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .lblPasswordIsEmpty;
                            } else if (value.length < 8) {
                              return AppLocalizations.of(context)!
                                  .lblPasswordMustBeMoreThan;
                            } else if (value !=
                                passwordCubit.passwordController.text) {
                              return AppLocalizations.of(context)!
                                  .lblPasswordDontMatch;
                            } else {
                              return null;
                            }
                          },
                          passwordOnChanged: (String? value) {
                            passwordCubit.checkPasswordFieldValid(value!);

                            return value;
                          },
                        ),

                        ///Spacer
                        getSpaceHeight(SharedText.screenHeight * 0.088),

                        CommonGlobalButton(
                          isEnable: passwordCubit
                                  .passwordController.text.isNotEmpty &&
                              passwordCubit
                                  .confirmPasswordController.text.isNotEmpty,
                          isLoading:
                              passwordStates is ChangePasswordStateLoading,
                          buttonText: AppLocalizations.of(passwordCtx)!.lblSend,
                          onPressedFunction: () {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(passwordCtx)
                                  .requestFocus(FocusNode());
                              passwordCubit.changeNewPassword(
                                  userCredential:
                                      widget.routeArgument.userCredential!,
                                  confirmPassword: passwordCubit
                                      .confirmPasswordController.text,
                                  otp: widget.routeArgument.otp!,
                                  password:
                                      passwordCubit.passwordController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
