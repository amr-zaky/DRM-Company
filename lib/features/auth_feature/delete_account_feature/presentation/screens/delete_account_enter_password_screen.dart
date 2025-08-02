import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../password_feature/presentation/logic/password_cubit/password_cubit.dart';
import '../../../password_feature/presentation/logic/password_cubit/password_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/password_form_widget.dart';

class DeleteAccountEnterPasswordScreen extends StatefulWidget {
  const DeleteAccountEnterPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountEnterPasswordScreen> createState() =>
      _DeleteAccountEnterPasswordScreenState();
}

class _DeleteAccountEnterPasswordScreenState
    extends State<DeleteAccountEnterPasswordScreen> {
  late PasswordCubit _passwordCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordCubit = BlocProvider.of<PasswordCubit>(context);
    _passwordCubit.passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblDeleteAccount,
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<PasswordCubit, PasswordStates>(listener:
          (BuildContext passwordContext, PasswordStates passwordState) {
        if (passwordState is CheckPasswordSuccessState) {
          context.pushNamed(RouteNames.deleteAccountReasonRoute);
        } else if (passwordState is CheckPasswordFailedState) {
          checkUserAuth(
              context: passwordContext, errorType: passwordState.error.type);
          showSnackBar(
              context: context,
              title: passwordState.error.type.getErrorMessage(context) ??
                  passwordState.error.errorMassage,
              color: AppConstants.lightRedColor);
        }
      }, builder: (BuildContext context, PasswordStates state) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () => hideKeyboard(context),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidgetWidth(AppConstants.padding16)),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getSpaceHeight(AppConstants.padding24),
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!
                            .lblDeleteAccountPassword,
                        textWeight: FontWeight.w500,
                        textFontSize: AppConstants.fontSize12,
                        minTextFontSize: AppConstants.fontSize12,
                        textColor: AppConstants.borderInputColor,
                        lines: 5,
                        textHeight: 0,
                      ),
                      getSpaceHeight(AppConstants.padding32),
                      PasswordFormWidget(
                        passwordController: _passwordCubit.passwordController,
                        passwordOnChanged: (String? fieldValue) {
                          _passwordCubit.checkPasswordFieldValid(fieldValue!);
                          return fieldValue;
                        },
                        showPasswordText: _passwordCubit.hidePassword,
                        onSuffixTap: () => _passwordCubit.toggleHidePassword(),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CommonGlobalButton(
                        buttonText: AppLocalizations.of(context)!.lblNext,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            _passwordCubit.checkPassword();
                          }
                        },
                        buttonBackgroundColor: AppConstants.appBarTitleColor,
                        radius: AppConstants.borderRadius8,
                        icon: RotatedBox(
                          quarterTurns:
                              SharedText.currentLocale == "ar" ? 0 : 2,
                          child: const CommonAssetSvgImageWidget(
                              imageString: IconPath.leftLineArrowIcon,
                              height: 16,
                              width: 16),
                        ),
                        isLoading: state is CheckPasswordLoadingState,
                        isEnable: state is! CheckPasswordLoadingState &&
                            _passwordCubit.passwordValidation,
                      ),
                    ],
                  ),
                  getSpaceHeight(SharedText.screenHeight * 0.4)
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
