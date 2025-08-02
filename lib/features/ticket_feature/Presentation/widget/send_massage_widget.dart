import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/keys/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/widgets/common_loading_widget.dart';
import '../../../../core/presentation/widgets/common_text_form_field_widget.dart';
import '../logic/ticket_chat_cubit/ticket_chat_cubit.dart';
import '../logic/ticket_chat_cubit/ticket_chat_states.dart';

class SendMassageWidget extends StatelessWidget {
  const SendMassageWidget(
      {Key? key, required this.ticketId, required this.isReadOnly})
      : super(key: key);
  final String ticketId;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(AppConstants.padding16)),
      height: 88,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppConstants.lightWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.borderRadius24),
            topRight: Radius.circular(AppConstants.borderRadius24),
          ),
        ),
        shadows: <BoxShadow>[
          BoxShadow(
            color: AppConstants.lightBlackColor.withOpacity(0.16),
            blurRadius: 4,
          )
        ],
      ),
      child: BlocConsumer<TicketChatCubit, TicketChatStates>(
        listener: (BuildContext chatCtx, TicketChatStates chatState) {
          if (chatState is TicketChatSendMessageSuccessState) {
            chatCtx.read<TicketChatCubit>().messageController.text = '';
          }
        },
        builder: (BuildContext chatCtx, TicketChatStates chatState) =>
            Row(children: <Widget>[
          Expanded(
            child: CommonTextFormField(
              isReadOnly: isReadOnly,
              controller: chatCtx.read<TicketChatCubit>().messageController,
              onChanged: (String? str) {
                return str;
              },
              hintKey: AppLocalizations.of(context)!.lblWriteHere,
              keyboardType: TextInputType.multiline,
              radius: 100,
              contentPaddingHorizontal: 16,
              labelHintStyle: AppConstants.borderInputColor.withOpacity(.3),
              hintFontSize: AppConstants.fontSize12,
              action: TextInputAction.newline,
              maxLines: 6,
              validator: (String? phone) {
                return null;
              },
            ),
          ),
          getSpaceWidth(AppConstants.padding8),
          if (chatState is! TicketChatSendMessageLoadingState) ...<Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                // hideKeyboard(context);
                if (chatCtx
                    .read<TicketChatCubit>()
                    .messageController
                    .text
                    .isNotEmpty) {
                  chatCtx.read<TicketChatCubit>().sendMessage(
                      ticketId: ticketId,
                      message: chatCtx
                          .read<TicketChatCubit>()
                          .messageController
                          .text);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: AppConstants.backBGColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: AppConstants.shadowColor,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: const CommonAssetSvgImageWidget(
                  imageString: IconPath.sendCommentIcon,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ] else ...<Widget>[
            const CommonLoadingWidget(),
          ]
        ]),
      ),
    );
  }
}
