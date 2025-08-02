import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/custom_snack_bar.dart';
import '../logic/help_cubit/help_cubit.dart';
import '../logic/help_cubit/help_states.dart';
import '/core/constants/enums/exception_enums.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController subjectController;
  late TextEditingController messageController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    subjectController = TextEditingController();
    messageController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblHelpAndSupport,
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<HelpCubit, HelpStates>(
            listener: (BuildContext helpCtx, HelpStates helpState) {
              if (helpState is HelpAddContactSuccessState) {
                showSnackBar(
                    context: context,
                    title: AppLocalizations.of(context)!.lblRequestSendSuccess,
                    color: AppConstants.successColor);
                context.pop();
              } else if (helpState is HelpAddContactFailState) {
                showSnackBar(
                    context: context,
                    title: helpState.error.type.getErrorMessage(context) ??
                        helpState.error.errorMassage);
              }
            },
            builder: (BuildContext helpCtx, HelpStates helpState) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidgetWidth(AppConstants.padding16),
                    vertical: getWidgetHeight(AppConstants.padding16)),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonTitleText(
                        textKey:
                            AppLocalizations.of(context)!.lblSendRequestTitle,
                        textColor: AppConstants.mainColor,
                        textFontSize: AppConstants.fontSize14,
                        textWeight: FontWeight.w600,
                      ),

                      getSpaceHeight(AppConstants.padding16),

                      ///subject
                      ///subject text field
                      CommonTextFormField(
                        controller: subjectController,
                        maxLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .lblSubjectIsEmpty;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String? str) {
                          return str;
                        },
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding16),

                      ///description
                      CommonTitleText(
                        textKey:
                            AppLocalizations.of(context)!.lblSendRequestTitle,
                        textColor: AppConstants.mainColor,
                        textFontSize: AppConstants.fontSize14,
                        textWeight: FontWeight.w600,
                      ),

                      ///spacera
                      getSpaceHeight(AppConstants.padding16),

                      ///description text field
                      CommonTextFormField(
                        controller: messageController,
                        hintKey:
                            AppLocalizations.of(context)!.lblWriteProblemDes,
                        labelHintStyle:
                            AppConstants.borderInputColor.withOpacity(.3),
                        hintFontSize: AppConstants.fontSize12,
                        contentPaddingHorizontal: 8,
                        action: TextInputAction.newline,
                        minLines: 5,
                        maxLines: 6,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .lblDescriptionIsEmpty;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String? str) {
                          return str;
                        },
                      ),

                      ///spacer
                      getSpaceHeight(200),

                      ///next Action
                      CommonGlobalButton(
                        buttonText: AppLocalizations.of(context)!.lblSend,
                        isLoading: helpState is HelpAddContactLoadingState,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            helpCtx.read<HelpCubit>().addContact(
                                  subject: subjectController.text,
                                  message: messageController.text,
                                );
                          }
                        },
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
