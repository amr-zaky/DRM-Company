import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/enums/page_enums.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/phone_form_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PasswordCubit _forgetPasswordCubit;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = BlocProvider.of<PasswordCubit>(context);
    _forgetPasswordCubit.resetState();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (BuildContext forgetCtx, PasswordStates forgetState) {
          if (forgetState is SendVerificationStateSuccess) {
            context.pushNamed(
              RouteNames.verificationCodePageRoute,
              extra: RouteArgument(
                  userCredential: phoneController.text,
                  sourcePage: SourcePageEnum.forgetPassword,
                  otp: forgetState.code),
            );
          } else if (forgetState is SendVerificationStateError) {
            showSnackBar(
                context: forgetCtx,
                title: forgetState.error!.type.getErrorMessage(context) ??
                    forgetState.error!.errorMassage);
          }
        },
        builder: (BuildContext context, PasswordStates state) {
          return GestureDetector(
            onTap: () {
              hideKeyboard(context);
            },
            child: SingleChildScrollView(
              child: SizedBox(
                width: SharedText.screenWidth,
                height: SharedText.screenHeight,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding16),
                    child: Column(
                      children: <Widget>[
                        const CommonAssetSvgImageWidget(
                            imageString: "forget_password.svg",
                            height: 88,
                            width: 88,
                            fit: BoxFit.contain),

                        getSpaceHeight(AppConstants.padding16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblEnterPhoneNumber,
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
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblCodeWillSendToPhone,
                              textColor: AppConstants.lightGrayOffColor,
                            ),
                          ],
                        ),
                        getSpaceHeight(AppConstants.padding16),

                        ///Phone
                        PhoneFormWidget(
                          phoneController: phoneController,
                          phoneOnChanged: (String? value) {
                            setState(() {});
                            return value;
                          },
                        ),
                        getSpaceHeight(250),
                        Center(
                          child: CommonGlobalButton(
                            buttonBackgroundColor: AppConstants.appBarTitleColor,
                            radius: AppConstants.borderRadius8,
                            buttonTextSize: AppConstants.fontSize16,
                            isEnable: phoneController.text.isNotEmpty,
                            isLoading: state is SendVerificationStateLoading,
                            buttonText: AppLocalizations.of(context)!.lblSend,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.pushNamed(
                                  RouteNames.verificationCodePageRoute,
                                  extra: RouteArgument(
                                    userCredential: phoneController.text,
                                    sourcePage: SourcePageEnum.forgetPassword,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        getSpaceHeight(50)
                      ],
                    ),
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
