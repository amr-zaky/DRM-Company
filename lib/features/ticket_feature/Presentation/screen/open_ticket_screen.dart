import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/feature/filter_feature/presentation/select_item_pop_up.dart';
import '../../../../core/presentation/routes/route_argument.dart';
import '../../Domain/model/ticket_reason_model.dart';
import '../logic/ticket_cubit/ticket_cubit.dart';
import '../logic/ticket_cubit/ticket_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_empty_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_text_form_field_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';

class OpenTicketScreen extends StatefulWidget {
  const OpenTicketScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OpenTicketScreen> createState() => _OpenTicketScreenState();
}

class _OpenTicketScreenState extends State<OpenTicketScreen> {
  late GlobalKey<FormState> forKey;
  late TextEditingController noteController;
  late TextEditingController contentController;
  late TextEditingController otherFieldController;
  late TicketCubit _ticketCubit;

  @override
  void initState() {
    super.initState();
    _ticketCubit = TicketCubit.get(context);
    forKey = GlobalKey<FormState>();
    noteController = TextEditingController();
    contentController = TextEditingController();
    otherFieldController = TextEditingController();
    _ticketCubit.getTicketReasons();
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
    contentController.dispose();
    otherFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblAddReport,
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppConstants.padding16),
          child: SingleChildScrollView(
            child: BlocConsumer<TicketCubit, TicketStates>(
              listener: (BuildContext ticketCtx, TicketStates ticketState) {
                if (ticketState is TicketSentSuccessState) {
                  context.pushReplacementNamed(RouteNames.ticketChatPageRoute,
                      extra: RouteArgument(
                        ticketModel: ticketState.ticketModel,
                      ));
                  TicketCubit.get(context).getTickets();
                }
              },
              builder: (BuildContext ticketCtx, TicketStates ticketState) {
                if (ticketState is TicketGetTicketReasonLoadingState) {
                  return SizedBox(
                    height: SharedText.screenHeight,
                    width: SharedText.screenWidth,
                    child: Column(
                      children: <Widget>[
                        LoadingShimmer(
                          height: 70,
                          width: SharedText.screenWidth,
                        ),
                        getSpaceHeight(AppConstants.padding16),
                        LoadingShimmer(
                          height: 60,
                          width: SharedText.screenWidth,
                        ),
                        getSpaceHeight(AppConstants.padding16),
                        LoadingShimmer(
                          height: 140,
                          width: SharedText.screenWidth,
                        ),
                        getSpaceHeight(200),
                        LoadingShimmer(
                          height: 50,
                          width: SharedText.screenWidth,
                          radius: AppConstants.borderRadius24,
                        ),
                        getSpaceHeight(AppConstants.padding8),
                      ],
                    ),
                  );
                } else if (ticketState is TicketGetTicketReasonEmptyState) {
                  return EmptyScreen(
                      imageString: 'no_internet.svg',
                      titleKey: AppLocalizations.of(context)!.lblEmptyReason,
                      imageHeight: 212,
                      imageWidth: 180);
                } else if (ticketState is TicketGetTicketReasonFailState) {
                  return CommonError(
                    errorMassage: ticketState.error.errorMassage,
                    errorType: ticketState.error.type,
                    withButton: true,
                    onTap: () {
                      _ticketCubit.getTicketReasons();
                    },
                  );
                } else {
                  return Form(
                    key: forKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///description
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(context)!.lblSendRequestTitle,
                          textColor: AppConstants.mainColor,
                          textFontSize: AppConstants.fontSize14,
                          textWeight: FontWeight.w600,
                        ),

                        ///Spacer
                        getSpaceHeight(AppConstants.padding8),

                        CommonTextFormField(
                          hintKey: _ticketCubit.selectedReason == null
                              ? AppLocalizations.of(context)!.lblSelectReason
                              : _ticketCubit.selectedReason!.name,
                          keyboardType: TextInputType.text,
                          isReadOnly: true,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CommonAssetSvgImageWidget(
                                imageString: IconPath.rightArrowIcon,
                                height: 14,
                                width: 14,
                              ),
                            ),
                          ),
                          onTap: () {
                            advancedSearchPopUP(
                                context: context,
                                title: AppLocalizations.of(context)!
                                    .lblSelectReason,
                                listOfItem: _ticketCubit.ticketReasonList,
                                selectedModel: _ticketCubit.selectedReason,
                                isListHaveSearch: false,
                                heightFactor: 0.55,
                                onApply: (dynamic value) {
                                  _ticketCubit
                                      .selectReason(value as TicketReasonModel);
                                });
                          },
                          contentPaddingHorizontal: AppConstants.padding8,
                          onChanged: (String? value) {
                            return value;
                          },
                        ),

                        ///Spacer
                        getSpaceHeight(AppConstants.padding16),

                        ///subject
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!
                              .lblTicketReasonsTitle,
                          textColor: AppConstants.mainColor,
                          textFontSize: AppConstants.fontSize14,
                          textWeight: FontWeight.w600,
                        ),
                        getSpaceHeight(AppConstants.padding8),

                        ///subject text field
                        CommonTextFormField(
                          controller: noteController,
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
                          textKey: AppLocalizations.of(context)!.lblProblemDes,
                          textColor: AppConstants.mainColor,
                          textFontSize: AppConstants.fontSize14,
                          textWeight: FontWeight.w500,
                        ),

                        ///spacer
                        getSpaceHeight(AppConstants.padding8),

                        ///description text field
                        CommonTextFormField(
                          controller: contentController,
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
                        getSpaceHeight(250),

                        /// Confirm Button
                        CommonGlobalButton(
                          buttonText: AppLocalizations.of(context)!.lblSend,
                          isLoading: ticketState is TicketSentLoadingState,
                          onPressedFunction: () {
                            if (forKey.currentState!.validate()) {
                              _ticketCubit.openProblemTicket(
                                  reasonId: _ticketCubit.selectedReason!.id!,
                                  note: noteController.text,
                                  subject: contentController.text);
                            }
                          },
                        ),
                        getSpaceHeight(80),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
