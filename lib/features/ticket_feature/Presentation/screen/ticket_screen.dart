import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/ticket_cubit/ticket_cubit.dart';
import '../logic/ticket_cubit/ticket_states.dart';
import '../widget/ticket_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/loading_widgets/list_loader_widget.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late TicketCubit ticketCubit;

  @override
  void initState() {
    super.initState();
    ticketCubit = TicketCubit.get(context);
    ticketCubit.getTickets();
    ticketCubit.ticketScrollController = ScrollController();
    ticketCubit.ticketScrollController.addListener(
      () {
        ticketCubit.setupTicketScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblYourProblems,
      ),
      body: BlocConsumer<TicketCubit, TicketStates>(
        listener: (BuildContext ticketCtx, TicketStates ticketState) {
          if (ticketState is TicketGetDataEmptyState) {
            // context
            //     .pushNamed(
            //       RouteNames.openTicketPageRoute,
            //     )
            //     .then((Object? value) => ticketCubit.getTickets());
            // context
            //     .pushReplacementNamed(RouteNames.reasonsHomePageRoute,
            //         extra: RouteArgument(reasonKey: ReasonKey.ticketReasons))
            //     .then((value) => ticketCubit.getTickets());
          }
        },
        builder: (BuildContext ticketCtx, TicketStates ticketState) {
          if (ticketState is TicketGetDataLoadingState) {
            return ListLoaderWidget(
              itemCount: 10,
              itemHeight: getWidgetHeight(85),
              padding: EdgeInsets.symmetric(
                vertical: getWidgetHeight(AppConstants.padding8),
                horizontal: getWidgetWidth(AppConstants.padding8),
              ),
            );
          } else if (ticketState is TicketGetDataFailState) {
            return CommonError(
              withButton: true,
              errorMassage: ticketState.error.errorMassage,
              errorType: ticketState.error.type,
              onTap: () {
                ticketCubit.getTickets();
              },
            );
          } else {
            return Column(
              children: <Widget>[
                if (ticketCubit.ticketList.isEmpty) ...[
                  getSpaceHeight(AppConstants.padding36),
                  EmptyScreen(
                      imageString: IconPath.emptyIcon,
                      titleKey: AppLocalizations.of(context)!.lblNoData,
                      imageHeight: 200,
                      imageWidth: 200),
                  getSpaceHeight(AppConstants.padding36),
                ] else ...[
                  SizedBox(
                    height: SharedText.screenHeight - 200,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: getWidgetHeight(AppConstants.padding8)),
                      shrinkWrap: true,
                      controller: ticketCubit.ticketScrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: ticketCubit.ticketList.length + 1,
                      separatorBuilder: (BuildContext context, int index) =>
                          getSpaceHeight(AppConstants.padding8),
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= ticketCubit.ticketList.length &&
                            ticketCubit.ticketHasMoreData) {
                          return const CommonLoadingWidget();
                        } else if (index >= ticketCubit.ticketList.length) {
                          return const SizedBox();
                        } else {
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    RouteNames.ticketChatPageRoute,
                                    extra: RouteArgument(
                                        ticketModel:
                                            ticketCubit.ticketList[index]),
                                  );
                                },
                                child: TicketWidget(
                                    model: ticketCubit.ticketList[index]),
                              ),
                              if (ticketState is TicketGetMoreDataState &&
                                  ticketCubit.ticketList.length - 1 == index)
                                const CommonLoadingWidget()
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],

                ///100
                getSpaceHeight(20),
                CommonGlobalButton(
                    buttonText: AppLocalizations.of(context)!.lblAddReport,
                    onPressedFunction: () {
                      context.pushNamed(
                        RouteNames.openTicketPageRoute,
                      );
                    }),
              ],
            );
          }
        },
      ),
    );
  }
}
