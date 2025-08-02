import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Domain/model/chat_model.dart';
import '../logic/ticket_chat_cubit/ticket_chat_cubit.dart';
import '../logic/ticket_chat_cubit/ticket_chat_states.dart';
import '../widget/chat_loader_widget.dart';
import '../widget/chat_massage_item.dart';
import '../widget/send_massage_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/massage_type.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/routes/route_argument.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';

class TicketChat extends StatefulWidget {
  const TicketChat({
    Key? key,
    required this.routeArgument,
  }) : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<TicketChat> createState() => _TicketChatState();
}

class _TicketChatState extends State<TicketChat> with WidgetsBindingObserver {
  late TicketChatCubit ticketChatCubit;

  @override
  void initState() {
    super.initState();
    ticketChatCubit = TicketChatCubit.get(context);
    ticketChatCubit.getTicketComments(
        ticketId: widget.routeArgument.ticketModel!.id.toString());

    ticketChatCubit.ticketScrollController = ScrollController();
    ticketChatCubit.ticketScrollController.addListener(
      () {
        ticketChatCubit.setupTicketScrollController(
            widget.routeArgument.ticketModel!.id.toString());
      },
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        pageTitle: widget.routeArgument.ticketModel!.subject,
        onBackPressed: () {
          hideKeyboard(context);
          context.pop();
        },
      ),
      body: BlocConsumer<TicketChatCubit, TicketChatStates>(
          listener: (BuildContext context, TicketChatStates state) {},
          builder: (BuildContext context, TicketChatStates state) {
            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () => hideKeyboard(context),
              child: Column(
                children: <Widget>[
                  if (state is TicketChatGetDataFailState) ...<Widget>[
                    CommonError(
                      errorMassage: state.error.errorMassage,
                      errorType: state.error.type,
                      withButton: true,
                      onTap: () {
                        ticketChatCubit.getTicketComments(
                            ticketId: widget.routeArgument.ticketModel!.id
                                .toString());
                      },
                    )
                  ] else ...<Widget>[
                    if (state is TicketChatGetDataLoadingState) ...<Widget>[
                      const ChatLoaderWidget(),
                    ] else ...<Widget>[
                      Expanded(
                        child: ListView.separated(
                            controller: ticketChatCubit.ticketScrollController,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    getWidgetWidth(AppConstants.padding16),
                                vertical:
                                    getWidgetHeight(AppConstants.padding16)),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ChatMassageItem(
                                  isMe: ticketChatCubit
                                          .comments[index].senderType ==
                                      "account",
                                  model: ChatMassageModel(
                                    massageContent:
                                        ticketChatCubit.comments[index].comment,
                                    massageType: MassageType.text,
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return getSpaceHeight(AppConstants.padding16);
                            },
                            itemCount: ticketChatCubit.comments.length),
                      ),
                    ],
                    if (widget.routeArgument.ticketModel!.isOpen)
                      SendMassageWidget(
                        isReadOnly: state is TicketChatGetDataLoadingState,
                        ticketId:
                            widget.routeArgument.ticketModel!.id.toString(),
                      ),
                  ],
                ],
              ),
            );
          }),
    );
  }
}
