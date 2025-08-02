import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/feature/filter_feature/presentation/select_item_pop_up.dart';

import 'package:base_project_repo/core/presentation/widgets/common_row_error_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';
import 'package:base_project_repo/features/product_feature/presentation/logic/product_cubit.dart';
import 'package:base_project_repo/features/product_feature/presentation/logic/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../logic/sign_up_cubit/sign_up_cubit.dart';
import '../logic/sign_up_cubit/sign_up_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/enums/page_enums.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_person_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/email_form_widget.dart';
import '/core/presentation/widgets/form_input_widgets/name_form_widget.dart';
import '/core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '/core/presentation/widgets/form_input_widgets/phone_form_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit _signUpCubit;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    _signUpCubit.setupController();
    BlocProvider.of<ProductCubit>(context).getProductList();
  }

  @override
  void dispose() {
    _signUpCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (BuildContext loginCtx, SignUpStates signUpState) {
          if (signUpState is UserSignUpSuccessState) {
            showSnackBar(
              context: loginCtx,
              color: AppConstants.successColor,
              title: AppLocalizations.of(context)!.lblSignUpSuccess,
            );
            context.pushNamed(
              RouteNames.verificationCodePageRoute,
              extra: RouteArgument(
                  userCredential: _signUpCubit.phoneNumberController.text,
                  sourcePage: SourcePageEnum.verification),
            );
          }
          if (signUpState is UserSignUpErrorState) {
            showSnackBar(
              context: loginCtx,
              title: signUpState.error!.type.getErrorMessage(context) ??
                  signUpState.error!.errorMassage,
            );
          }
        },
        builder: (BuildContext signUpCtx, SignUpStates signUpstate) {
          return PopScope(
            canPop: signUpstate is! UserSignUpLoadingState,
            child: InkWell(
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
                  ),
                  SizedBox(
                    width: SharedText.screenWidth,
                    height: SharedText.screenHeight,
                    child: Column(
                      children: <Widget>[
                        getSpaceHeight(80),

                        ///app logo
                        const CommonAssetSvgImageWidget(
                          imageString: IconPath.appIcon,
                          height: 64,
                          width: 164,
                        ),

                        ///spacer
                        getSpaceHeight(
                          AppConstants.padding24,
                        ),

                        /// Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!.lblWelcome,
                              textColor: AppConstants.mainColor,
                              textWeight: FontWeight.w500,
                              textFontSize: AppConstants.fontSize18,
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
                                    .lblOnBoardingSub2,
                                textAlignment: TextAlign.center,
                                textColor: AppConstants.lightGrayOffColor,
                                lines: 2,
                              ),
                            ),
                          ],
                        ),
                        getSpaceHeight(
                          AppConstants.padding16,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.padding16) +
                                EdgeInsets.only(
                                  bottom: MediaQuery.of(signUpCtx)
                                      .viewInsets
                                      .bottom,
                                ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                /// Upload Image
                                Form(
                                  key: _signUpCubit.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      getSpaceHeight(AppConstants.padding16),

                                      /// User Name
                                      NameFormWidget(
                                        nameController:
                                            _signUpCubit.userNameController,
                                        iconPath: IconPath.companyNameIcon,
                                        nameOnChanged: (String? value) {
                                          _signUpCubit.isDataFount();
                                          return null;
                                        },
                                      ),

                                      getSpaceHeight(AppConstants.padding16),
                                      NameFormWidget(
                                          nameController:
                                              _signUpCubit.taxNumberController,
                                          iconPath: IconPath.companyTaxIcon,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .lblCompanyTax,
                                          nameOnChanged: (String? value) {
                                            _signUpCubit.isDataFount();
                                            return null;
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameIsEmpty;
                                            } else if (value.length < 5) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameLength;
                                            } else {
                                              return null;
                                            }
                                          }),
                                      getSpaceHeight(AppConstants.padding16),
                                      NameFormWidget(
                                          nameController: _signUpCubit
                                              .companyNumberController,
                                          iconPath: IconPath.companyNumberIcon,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .lblCompanyNumber,
                                          nameOnChanged: (String? value) {
                                            _signUpCubit.isDataFount();
                                            return null;
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameIsEmpty;
                                            } else if (value.length < 5) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameLength;
                                            } else {
                                              return null;
                                            }
                                          }),
                                      getSpaceHeight(AppConstants.padding16),

                                      /// Phone

                                      PhoneFormWidget(
                                        phoneController:
                                            _signUpCubit.phoneNumberController,
                                        phoneOnChanged: (String? value) {
                                          _signUpCubit.isDataFount();
                                          return null;
                                        },
                                      ),
                                      getSpaceHeight(AppConstants.padding16),

                                      /// Email
                                      EmailFormWidget(
                                        emailController:
                                            _signUpCubit.emailAddressController,
                                        emailOnChanged: (String? value) {
                                          _signUpCubit.isDataFount();
                                          return value;
                                        },
                                      ),

                                      ///spacer

                                      getSpaceHeight(AppConstants.padding16),

                                      /// Password
                                      PasswordFormWidget(
                                        passwordController:
                                            _signUpCubit.passwordController,
                                        onSuffixTap:
                                            _signUpCubit.switchPasswordToggle,
                                        showPasswordText:
                                            _signUpCubit.hidePassword,
                                        passwordOnChanged: (String? value) {
                                          _signUpCubit.isDataFount();
                                          return value;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.padding16),

                                      /// Confirm Password
                                      PasswordFormWidget(
                                        passwordController: _signUpCubit
                                            .confirmPasswordController,
                                        onSuffixTap: () {
                                          _signUpCubit.switchPasswordToggle(
                                              isMainPassword: false);
                                        },
                                        hintText: AppLocalizations.of(context)!
                                            .lblConfirmNewPassword,
                                        showPasswordText:
                                            _signUpCubit.hideConfirmPassword,
                                        passwordValidator: (String? value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblPasswordIsEmpty;
                                          } else if (value.length < 8) {
                                            return AppLocalizations.of(context)!
                                                .lblPasswordMustBeMoreThan;
                                          } else if (value !=
                                              _signUpCubit
                                                  .passwordController.text) {
                                            return AppLocalizations.of(context)!
                                                .lblPasswordDontMatch;
                                          } else {
                                            return null;
                                          }
                                        },
                                        passwordOnChanged: (String? value) {
                                          _signUpCubit.isDataFount();
                                          return value;
                                        },
                                      ),
                                      getSpaceHeight(AppConstants.padding16),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidgetWidth(
                                                AppConstants.padding4)),
                                        child: SizedBox(
                                          height: getWidgetHeight(48),
                                          width: SharedText.screenWidth,
                                          child: BlocConsumer<ProductCubit,
                                              ProductStates>(
                                            listener: (BuildContext context,
                                                ProductStates state) {
                                              if (state is ProductErrorState) {
                                                showSnackBar(
                                                    context: context,
                                                    title: state
                                                        .error!.errorMassage);
                                                checkUserAuth(
                                                    context: context,
                                                    errorType:
                                                        state.error!.type);
                                              }
                                            },
                                            builder: (BuildContext context,
                                                ProductStates state) {
                                              if (state
                                                  is ProductLoadingState) {
                                                return const LoadingShimmer(
                                                  height: 48,
                                                );
                                              } else if (state
                                                  is ProductErrorState) {
                                                return CommonErrorRowWidget(
                                                  errorMessage:
                                                      state.error!.errorMassage,
                                                  errorType: state.error!.type,
                                                );
                                              } else if (state
                                                  is ProductSuccessState) {
                                                return InkWell(
                                                  onTap: () {
                                                    advancedSearchPopUP(
                                                      context: context,
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .lblSelectProductsYouProvide,
                                                      onApply: (select) {
                                                        signUpCtx
                                                            .read<SignUpCubit>()
                                                            .setProductList(
                                                                select);
                                                      },
                                                      listOfItem: BlocProvider
                                                              .of<ProductCubit>(
                                                                  context)
                                                          .productList,
                                                      multiSelectData: signUpCtx
                                                          .read<SignUpCubit>()
                                                          .productList,
                                                      isMultiSelect: true,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: getWidgetHeight(48),
                                                    decoration: BoxDecoration(
                                                      color: AppConstants
                                                          .lightWhiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: const <BoxShadow>[
                                                        BoxShadow(
                                                          color: AppConstants
                                                              .shadowColor,
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            getWidgetWidth(
                                                                AppConstants
                                                                    .padding8)),
                                                    child: Row(
                                                      children: <Widget>[
                                                        if (signUpCtx
                                                            .read<SignUpCubit>()
                                                            .productList
                                                            .isEmpty) ...<Widget>[
                                                          CommonTitleText(
                                                            textKey: AppLocalizations
                                                                    .of(context)!
                                                                .lblSelectProductsYouProvide,
                                                          )
                                                        ] else ...<Widget>[
                                                          Expanded(
                                                            child:
                                                                CommonTitleText(
                                                              textKey: signUpCtx
                                                                  .read<
                                                                      SignUpCubit>()
                                                                  .productList
                                                                  .join(", "),
                                                              lines: 2,
                                                            ),
                                                          )
                                                        ]
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text("No Data"),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),

                                      ///spacer
                                      getSpaceHeight(
                                          AppConstants.padding36 * 2),

                                      /// Create Account Button
                                      CommonGlobalButton(
                                        buttonBackgroundColor:
                                            AppConstants.appBarTitleColor,
                                        isEnable: _signUpCubit.isDataFound,
                                        isLoading: signUpstate
                                            is UserSignUpLoadingState,
                                        buttonTextSize: 18,
                                        buttonText:
                                            AppLocalizations.of(signUpCtx)!
                                                .lblCreateAccount,
                                        onPressedFunction: () {
                                          if (_signUpCubit.formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(signUpCtx)
                                                .requestFocus(FocusNode());
                                            _signUpCubit.singUp(
                                                email: _signUpCubit
                                                    .emailAddressController
                                                    .text,
                                                password: _signUpCubit
                                                    .passwordController.text,
                                                taxNumber: _signUpCubit
                                                    .taxNumberController.text,
                                                companyNumber: _signUpCubit
                                                    .companyNumberController
                                                    .text,
                                                confirmPassword: _signUpCubit
                                                    .confirmPasswordController
                                                    .text,
                                                phone: _signUpCubit
                                                    .phoneNumberController.text,
                                                username: _signUpCubit
                                                    .userNameController.text,
                                                token: "SharedText.deviceToken",
                                                products:
                                                    _signUpCubit.productList);
                                          }
                                        },
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
                                                RouteNames.loginHomePageRoute,
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                CommonTitleText(
                                                  textKey: AppLocalizations.of(
                                                          context)!
                                                      .lblAlreadyUser,
                                                  textColor: AppConstants
                                                      .lightGrayOffColor,
                                                ),
                                                CommonTitleText(
                                                  textKey: AppLocalizations.of(
                                                          context)!
                                                      .lblSignIn,
                                                  textColor:
                                                      AppConstants.mainColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      getSpaceHeight(AppConstants.padding32),

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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
