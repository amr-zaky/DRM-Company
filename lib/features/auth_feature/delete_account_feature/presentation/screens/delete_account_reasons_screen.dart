import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../widgets/common_reason_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_empty_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/common_text_form_field_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/features/auth_feature/delete_account_feature/presentation/logic/delete_account_cubit.dart';
import '/features/auth_feature/delete_account_feature/presentation/logic/delete_account_states.dart';

class DeleteAccountReasonScreen extends StatefulWidget {
  const DeleteAccountReasonScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountReasonScreen> createState() =>
      _DeleteAccountReasonScreenState();
}

class _DeleteAccountReasonScreenState extends State<DeleteAccountReasonScreen> {
  late DeleteAccountCubit _accountCubit;
  late GlobalKey<FormState> forKey;

  @override
  void initState() {
    super.initState();
    forKey = GlobalKey<FormState>();
    _accountCubit = BlocProvider.of<DeleteAccountCubit>(context);
    _accountCubit.getReasons();
    _accountCubit.noteController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblDeleteAccount,
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: BlocConsumer<DeleteAccountCubit, DeleteAccountStates>(listener:
            (BuildContext deleteAccountCtx,
                DeleteAccountStates deleteAccountState) {
          if (deleteAccountState is DeleteAccountSuccessState) {
            context.pushReplacementNamed(RouteNames.onBoardingPageRoute);
          }
        }, builder: (BuildContext deleteAccountCtx,
            DeleteAccountStates deleteAccountState) {
          if (deleteAccountState is DeleteAccountReasonsLoadingState) {
            return const CommonLoadingWidget();
          } else if (deleteAccountState is DeleteAccountReasonsEmptyState) {
            return EmptyScreen(
                imageString: IconPath.emptyIcon,
                titleKey: AppLocalizations.of(context)!.lblEmptyReason,
                imageHeight: 212,
                imageWidth: 180);
          } else if (deleteAccountState is DeleteAccountFailedState) {
            return CommonError(
              errorMassage: deleteAccountState.customError.errorMassage,
              errorType: deleteAccountState.customError.type,
              withButton: true,
              onTap: () {
                _accountCubit.getReasons();
              },
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidgetWidth(AppConstants.padding16)),
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!
                              .lblDeleteAccountReasonsTitle,
                          textWeight: FontWeight.w500,
                          textFontSize: AppConstants.fontSize12,
                          minTextFontSize: AppConstants.fontSize12,
                          textColor: AppConstants.borderInputColor,
                        ),
                        getSpaceHeight(AppConstants.padding24),

                        /// Reasons
                        Column(
                          children: List<CommonReasonWidget>.generate(
                              _accountCubit.reasons.length, (int index) {
                            return CommonReasonWidget(
                              reasonModel: _accountCubit.reasons[index],
                              onTap: () {
                                _accountCubit
                                    .selectReason(_accountCubit.reasons[index]);
                              },
                              isSelected:
                                  _accountCubit.selectedReasonModel?.id! ==
                                      _accountCubit.reasons[index].id!,
                            );
                          }).toList(),
                        ),
                        if (_accountCubit.isOthersSelected)
                          Form(
                            key: forKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                getSpaceHeight(16),
                                CommonTextFormField(
                                  controller: _accountCubit.noteController,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblWriteYourComment,
                                  labelHintStyle: AppConstants.borderInputColor
                                      .withOpacity(.3),
                                  hintFontSize: AppConstants.fontSize12,
                                  contentPaddingHorizontal: 8,
                                  minLines: 4,
                                  maxLines: 5,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblFieldRequired;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CommonGlobalButton(
                        isLoading:
                            deleteAccountState is DeleteAccountLoadingState,
                        buttonText:
                            AppLocalizations.of(context)!.lblDeleteAccount,
                        onPressedFunction: () {
                          _accountCubit.deleteAccount(
                              reason: _accountCubit.selectedReasonModel!.title
                                  .toString(),
                              reasonNote: _accountCubit.noteController.text);
                        },
                        buttonBackgroundColor: AppConstants.mainColor,
                      ),
                      getSpaceHeight(SharedText.screenHeight * 0.4)
                    ],
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
