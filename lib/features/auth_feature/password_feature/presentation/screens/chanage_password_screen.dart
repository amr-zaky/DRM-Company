import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/password_form_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (BuildContext passwordCtx, PasswordStates passwordStates) {
          if (passwordStates is ChangePasswordStateSuccess) {
            showSnackBar(
                context: passwordCtx,
                title: AppLocalizations.of(context)!
                    .lblChangePasswordUpdateSuccess,
                color: AppConstants.successColor);
            context.pushReplacementNamed(RouteNames.loginHomePageRoute);
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
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getSpaceHeight(AppConstants.padding16),
                      PasswordFormWidget(
                        passwordController: passwordCubit.oldPasswordController,
                        onSuffixTap: passwordCubit.toggleHideOldPassword,
                        showPasswordText: passwordCubit.hideOldPassword,
                        hintText: AppLocalizations.of(context)!.lblOldPassword,
                        passwordOnChanged: (String? value) {
                          passwordCubit.checkPasswordFieldValid(value!);

                          return value;
                        },
                      ),

                      getSpaceHeight(AppConstants.padding16),

                      /// Password
                      PasswordFormWidget(
                        passwordController: passwordCubit.passwordController,
                        hintText: AppLocalizations.of(context)!.lblNewPassword,
                        onSuffixTap: passwordCubit.toggleHidePassword,
                        showPasswordText: passwordCubit.hidePassword,
                        passwordOnChanged: (String? value) {
                          passwordCubit.checkPasswordFieldValid(value!);

                          return value;
                        },
                        passwordValidator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .lblPasswordIsEmpty;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .lblPasswordMustBeMoreThan;
                          } else if (value ==
                              passwordCubit.oldPasswordController.text) {
                            return AppLocalizations.of(context)!
                                .lblPasswordMatchOld;
                          } else {
                            return null;
                          }
                        },
                      ),

                      getSpaceHeight(AppConstants.padding16),

                      /// Confirm Password
                      PasswordFormWidget(
                        passwordController:
                            passwordCubit.confirmPasswordController,
                        hintText:
                            AppLocalizations.of(context)!.lblConfirmNewPassword,
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

                      /// Retype Password
                      getSpaceHeight(260),

                      CommonGlobalButton(
                        buttonBackgroundColor: AppConstants.appBarTitleColor,
                        isEnable: passwordCubit.passwordValidation,
                        isLoading: passwordStates is ChangePasswordStateLoading,
                        radius: AppConstants.borderRadius8,
                        buttonText:
                            AppLocalizations.of(passwordCtx)!.lblSaveChanges,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(passwordCtx)
                                .requestFocus(FocusNode());
                            passwordCubit.changePassword(
                                oldPassword:
                                    passwordCubit.oldPasswordController.text,
                                password: passwordCubit.passwordController.text,
                                confirmPassword: passwordCubit
                                    .confirmPasswordController.text);
                          }
                        },
                      ),
                      getSpaceHeight(50),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
