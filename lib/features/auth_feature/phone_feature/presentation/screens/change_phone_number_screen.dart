import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/enums/page_enums.dart';
import '../../../../../core/presentation/routes/route_argument.dart';
import '../../../../../core/presentation/routes/route_names.dart';
import '../../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../../../password_feature/presentation/widget/check_password_bottom_sheet.dart';
import '../logic/phone_cubit/phone_cubit.dart';
import '../logic/phone_cubit/phone_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/form_input_widgets/phone_form_widget.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  late PhoneCubit _phoneCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneCubit = BlocProvider.of<PhoneCubit>(context);
    _phoneCubit.initialController();
  }

  @override
  void dispose() {
    _phoneCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblChangeMobileNumber,
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: SizedBox(
          height: SharedText.screenHeight,
          width: SharedText.screenWidth,
          child: BlocConsumer<PhoneCubit, PhoneStates>(
            listener: (BuildContext context, PhoneStates state) {
              if (state is PhoneSuccessState) {
                context.pushReplacementNamed(
                    RouteNames.verificationCodePageRoute,
                    extra: RouteArgument(
                        userCredential: _phoneCubit.newPhoneController.text,
                        sourcePage: SourcePageEnum.changePassword));
              } else if (state is PhoneFailedState) {
                showSnackBar(
                    context: context,
                    title: state.customError.type.getErrorMessage(context) ??
                        state.customError.errorMassage,
                    color: AppConstants.lightRedColor);
              }
            },
            builder: (BuildContext context, PhoneStates state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      getSpaceHeight(32),

                      /// Old Password
                      PhoneFormWidget(
                        phoneController: _phoneCubit.phoneController,
                        checkCurrentPhone: true,
                        phoneOnChanged: (String? value) {
                          _phoneCubit.checkIsDataValid();
                          return value;
                        },
                        hintKey: AppLocalizations.of(context)!.lblOldPhone,
                      ),
                      getSpaceHeight(AppConstants.padding16),

                      /// New Password
                      PhoneFormWidget(
                        phoneController: _phoneCubit.newPhoneController,
                        phoneOnChanged: (String? value) {
                          _phoneCubit.checkIsDataValid();
                          return value;
                        },
                        hintKey: AppLocalizations.of(context)!.lblNewPhone,
                      ),
                      getSpaceHeight(330),

                      /// Confirm Button
                      CheckPasswordBottomSheet(
                        phone: _phoneCubit.newPhoneController.text,
                        onPasswordChecked: (String pass) {
                          BlocProvider.of<PhoneCubit>(context).changePhone(
                              oldPhone: _phoneCubit.phoneController.text,
                              newPhone: _phoneCubit.newPhoneController.text,
                              password: pass);
                        },
                        isEnable: _phoneCubit.isDataValid,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
