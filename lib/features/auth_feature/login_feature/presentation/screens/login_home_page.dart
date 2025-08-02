import 'package:base_project_repo/core/presentation/widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/login_cubit/login_cubit.dart';
import '../logic/login_cubit/login_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/enums/page_enums.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '/core/presentation/widgets/form_input_widgets/phone_form_widget.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  late LoginCubit loginCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController userCredentialController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    userCredentialController = TextEditingController();
    passwordController = TextEditingController();
    loginCubit.initialController();
  }

  @override
  void dispose() {
    userCredentialController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext loginCtx, LoginStates loginState) {
          if (loginState is UserLogInSuccessState) {
            SharedText.isGuestMode = false;
            context.go(RouteNames.mainBottomNavPageRoute);
          }
          if (loginState is UserLoginErrorState) {
            if (loginState.error!.type ==
                CustomStatusCodeErrorType.unVerified) {
              context.pushNamed(
                RouteNames.verificationCodePageRoute,
                extra: RouteArgument(
                    userCredential: userCredentialController.text,
                    sourcePage: SourcePageEnum.verification),
              );
            }
            showSnackBar(
              context: loginCtx,
              title: loginState.error!.type.getErrorMessage(context) ??
                  loginState.error!.errorMassage,
            );
          }
        },
        builder: (BuildContext loginCtx, LoginStates loginState) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              hideKeyboard(context);
            },
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: SharedText.screenWidth,
                  height: SharedText.screenHeight,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ///spacer
                        getSpaceHeight(50),

                        ///app logo
                        const CommonAssetSvgImageWidget(
                          imageString: IconPath.appIcon,
                          height: 64,
                          width: 164,
                        ),

                        ///spacer
                        getSpaceHeight(
                          AppConstants.padding16,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.padding16) +
                                EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(loginCtx).viewInsets.bottom,
                                ),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                ///spacer

                                /// Title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblWelcomeAgain,
                                      textColor: AppConstants.mainColor,
                                      textWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                getSpaceHeight(AppConstants.padding8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: CommonTitleText(
                                        textKey: AppLocalizations.of(context)!
                                            .lblEnjoyOurService,
                                        textColor:
                                            AppConstants.lightGrayOffColor,
                                        lines: 2,
                                        textAlignment: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding24),

                                Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// Email
                                      PhoneFormWidget(
                                        phoneController:
                                            userCredentialController,
                                        phoneOnChanged: (String? value) {
                                          loginCubit
                                              .checkLoginFieldValid(value!);
                                          return value;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.padding16),

                                      PasswordFormWidget(
                                        passwordController: passwordController,
                                        onSuffixTap: loginCubit.togglePassword,
                                        showPasswordText:
                                            loginCubit.passwordToggle,
                                        passwordOnChanged: (String? value) {
                                          loginCubit
                                              .checkLoginFieldValid(value!);
                                          return value;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.padding8),

                                      /// Forget Password Button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              context.pushNamed(RouteNames
                                                  .forgetPasswordPageRoute);
                                            },
                                            child: CommonTitleText(
                                              textKey:
                                                  AppLocalizations.of(context)!
                                                      .lblIsForgetPassword,
                                              textColor: AppConstants
                                                  .lightGrayOffColor,
                                              textFontSize:
                                                  AppConstants.fontSize12,
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///spacer
                                      getSpaceHeight(200),

                                      ///login button
                                      CommonGlobalButton(
                                        buttonBackgroundColor:
                                            AppConstants.appBarTitleColor,
                                        isEnable: loginCubit.loginValidation,
                                        isLoading:
                                            loginState is UserLoginLoadingState,
                                        buttonTextSize: AppConstants.fontSize16,
                                        buttonTextFontWeight: FontWeight.w500,
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .lblLogin,
                                        onPressedFunction: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            loginCubit.login(
                                                userName:
                                                    userCredentialController
                                                        .text,
                                                password:
                                                    passwordController.text,
                                                token: SharedText.deviceToken);
                                          }
                                        },
                                        radius: AppConstants.borderRadius8,
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.padding16),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            onTap: () {
                                              context.pushReplacementNamed(
                                                RouteNames.singUpPageRoute,
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                CommonTitleText(
                                                  textKey: AppLocalizations.of(
                                                          context)!
                                                      .lblNewAccount,
                                                  textColor: AppConstants
                                                      .lightGrayOffColor,
                                                ),
                                                CommonTitleText(
                                                  textKey: AppLocalizations.of(
                                                          context)!
                                                      .lblCreateAccount,
                                                  textColor:
                                                      AppConstants.mainColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: SharedText.screenWidth,
                  height: SharedText.screenHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CommonAssetSvgImageWidget(
                        imageString: IconPath.backGroundPatternIcon,
                        height: 100,
                        width: SharedText.screenWidth,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
