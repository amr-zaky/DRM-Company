import 'package:base_project_repo/core/helpers/extensions/prevent_string_spacing.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../logic/otp_cubit/otp_cubit.dart';
import '../logic/otp_cubit/otp_states.dart';
import '../logic/timer_cubit/timer_cubit.dart';
import '../logic/timer_cubit/timer_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/enums/page_enums.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key, required this.routeArgument})
      : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<StatefulWidget> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late TextEditingController otpController;
  String? otp;
  String? otpError;
  late OtpCubit _otpCubit;
  late TimerCubit _timerCubit;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    _otpCubit = OtpCubit.get(context);
    _timerCubit = TimerCubit.get(context);
    _otpCubit.resetState();
    if (widget.routeArgument.otp == null) {
      _otpCubit.sendVerificationCode(
          userCredential: widget.routeArgument.userCredential!);
    } else {
      otp = widget.routeArgument.otp;
    }

    // if (widget.routeArgument.sourcePage == SourcePageEnum.forgetPassword ||
    //     widget.routeArgument.sourcePage == SourcePageEnum.changePassword) {
    // }
    // else if (widget.routeArgument.sourcePage == SourcePageEnum.verification)
    // {
    //   _otpCubit.resendOTP(
    //       userCredential: widget.routeArgument.userCredential!);
    // }

    _timerCubit.startTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timerCubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(),
      body: BlocConsumer<OtpCubit, OtpStates>(
        listener: (BuildContext otpCtx, OtpStates otpState) {
          if (otpState is OtpSuccessState) {
            if (widget.routeArgument.sourcePage ==
                SourcePageEnum.forgetPassword) {
              context.pushReplacementNamed(RouteNames.newPasswordPageRoute,
                  extra: RouteArgument(
                    userCredential: widget.routeArgument.userCredential,
                    otp: otp,
                  ));
            } else if (widget.routeArgument.sourcePage ==
                    SourcePageEnum.verification ||
                widget.routeArgument.sourcePage ==
                    SourcePageEnum.changePassword) {
              showSnackBar(
                  context: context,
                  title: AppLocalizations.of(context)!.lblAccountActivated,
                  color: AppConstants.successColor);
              SharedText.isGuestMode = false;
              context.go(RouteNames.mainBottomNavPageRoute);
            }
          } else if (otpState is ResendOtpSuccessState) {
            otp = otpState.otp;
          } else if (otpState is SendOtpSuccessState) {
            otp = otpState.otp;
          } else if (otpState is OtpErrorState) {
            otpError = otpState.error!.type.getErrorMessage(context) ??
                otpState.error!.errorMassage;
          }
        },
        builder: (BuildContext otpCtx, OtpStates otpState) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              hideKeyboard(context);
            },
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.padding16) +
                    EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                child: Column(
                  children: <Widget>[
                    getSpaceHeight(AppConstants.padding16),
                    const CommonAssetSvgImageWidget(
                        imageString: "forget_password.svg",
                        height: 88,
                        width: 88,
                        fit: BoxFit.contain),
                    getSpaceHeight(AppConstants.padding16),

                    ///title
                    CommonTitleText(
                      textKey:
                          "${AppLocalizations.of(otpCtx)!.lblEnterVerificationCode} - ${otp ?? ""}",
                      textFontSize: AppConstants.fontSize18,
                      textWeight: FontWeight.w600,
                    ),

                    ///spacer
                    getSpaceHeight(AppConstants.padding8),

                    ///sub title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(context)!.lblSendToYourEmail,
                          textColor: AppConstants.lightGrayOffColor,
                          textWeight: FontWeight.w500,
                        ),
                        CommonTitleText(
                          textKey: (widget.routeArgument.userCredential
                                  ?.addPhoneCountryCode() ??
                              "---"),
                          textColor: AppConstants.mainColor,
                          textWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    ///spacer
                    getSpaceHeight(48),

                    /// OTP
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.padding32),
                      child: Directionality(
                        textDirection: SharedText.currentLocale == "ar"
                            ? TextDirection.ltr
                            : TextDirection.ltr,
                        child: PinCodeTextField(
                          autoDisposeControllers: false,
                          textStyle: const TextStyle(
                              color: AppConstants.mainTextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                          length: 6,
                          keyboardType: TextInputType.number,
                          hintCharacter: '',
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius10,
                            ),
                            fieldHeight: getWidgetHeight(40),
                            fieldWidth: getWidgetWidth(40),
                            borderWidth: 1,
                            activeFillColor: AppConstants.lightWhiteColor,
                            inactiveColor: AppConstants.lightGrayColor,
                            selectedColor:
                                AppConstants.greenTextColor.withOpacity(0.3),
                            activeColor:
                                AppConstants.greenTextColor.withOpacity(0.3),
                            inactiveFillColor: AppConstants.lightWhiteColor,
                            selectedFillColor: AppConstants.lightWhiteColor,
                          ),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          controller: otpController,
                          onCompleted: (String v) {},
                          onChanged: (String value) {
                            _otpCubit.resetState();
                          },
                          beforeTextPaste: (String? text) {
                            return true;
                          },
                          appContext: otpCtx,
                        ),
                      ),
                    ),

                    if (otpError != null) ...<Widget>[
                      Center(
                        child: CommonTitleText(
                          textKey: otpError ??
                              AppLocalizations.of(context)!.lblWrongHappen,
                          textColor: AppConstants.lightRedColor,
                          textWeight: FontWeight.w700,
                        ),
                      )
                    ],

                    ///spacer
                    getSpaceHeight(AppConstants.padding16),

                    /// Resend code
                    BlocConsumer<TimerCubit, TimerStates>(
                      listener:
                          (BuildContext timerCtx, TimerStates timerState) {},
                      builder:
                          (BuildContext timerCtx, TimerStates timerState) =>
                              Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (_timerCubit.time != 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CommonTitleText(
                                  textKey: AppLocalizations.of(context)!
                                      .lblResendVerification,
                                  textWeight: FontWeight.w500,
                                  textColor: AppConstants.lightGrayOffColor,
                                ),
                                getSpaceWidth(AppConstants.padding4),
                                CommonTitleText(
                                  textKey: _timerCubit.time.toString() +
                                      AppLocalizations.of(context)!.lblSecond,
                                  textWeight: FontWeight.w500,
                                  textColor: AppConstants.greenTextColor,
                                ),
                              ],
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                if (_timerCubit.time != 0) {
                                  return;
                                } else {
                                  if (otpState is! OtpLoadingState) {
                                    otpError = null;
                                    if (_timerCubit.time > 0) {
                                    } else {
                                      _otpCubit.resendOTP(
                                        userCredential: widget
                                            .routeArgument.userCredential!,
                                      );
                                      _timerCubit.time = 59;
                                      _timerCubit.startTimer();
                                      otpController.clear();
                                    }
                                  }
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  CommonTitleText(
                                    textKey: AppLocalizations.of(context)!
                                        .lblDontRecieveCode,
                                    textColor: AppConstants.borderInputColor,
                                    textFontSize: AppConstants.padding12,
                                    textWeight: FontWeight.w500,
                                  ),
                                  CommonTitleText(
                                    textKey:
                                        AppLocalizations.of(context)!.lblResend,
                                    textColor: AppConstants.successColor,
                                    textFontSize: AppConstants.padding12,
                                    textWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    CommonGlobalButton(
                      height: 48,
                      buttonBackgroundColor: AppConstants.appBarTitleColor,
                      radius: AppConstants.borderRadius8,
                      buttonTextSize: 18,
                      isEnable: otpController.text.length == 6,
                      isLoading: otpState is OtpLoadingState ||
                          otpState is ResendOtpLoadingState,
                      buttonText: AppLocalizations.of(otpCtx)!.lblConfirm,
                      onPressedFunction: () {
                        if (widget.routeArgument.sourcePage ==
                            SourcePageEnum.forgetPassword) {
                          _otpCubit.checkOtp(
                              userCredential:
                                  widget.routeArgument.userCredential!,
                              otp: otpController.text);
                        } else {
                          _otpCubit.verifyAccount(
                              userCredential:
                                  widget.routeArgument.userCredential!,
                              otp: otpController.text);
                        }
                      },
                    ),

                    ///spacer
                    getSpaceHeight(50)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
