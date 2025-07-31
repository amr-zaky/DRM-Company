import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/factories/switch_factory.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/Alert_Dialogs/guest_mode_dialog.dart';
import '/core/presentation/widgets/common_waiting_dialog_widget.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/features/notification_feature/presentation/logic/notification_cubit.dart';
import '/features/notification_feature/presentation/logic/notification_states.dart';
import '/features/setting_feature/presentation/Screen/setting_widget/section_content_item.dart';

class NotificationSwitchWidget extends StatelessWidget {
  const NotificationSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationStates>(
      listener: (BuildContext context, NotificationStates state) {
        if (state is EnableOrDisableNotificationLoadingState) {
          showWaitingDialog(context);
        } else if (state is EnableOrDisableNotificationErrorState) {
          context.pop();
          showSnackBar(
              context: context,
              title: state.error!.type.getErrorMessage(context) ??
                  state.error!.errorMassage,
              color: AppConstants.lightRedColor);
        } else if (state is EnableOrDisableNotificationSuccessState) {
          context.pop();
        }
      },
      builder: (BuildContext context, NotificationStates state) {
        return SectionContentItem(
          title: AppLocalizations.of(context)!.lblNotification,
          actionWidget: Transform.scale(
            scale: Platform.isAndroid ? 1 : 0.8,
            child: SizedBox(
              height: getWidgetHeight(20),
              width: getWidgetWidth(48),
              child: PlatformSwitch.buildSwitch(
                context: context,
                value: NotificationCubit.get(context).isNotified,
                onChanged: (bool value) {
                  if (SharedText.isGuestMode) {
                    showGuestModeAlertDialog(context);
                  } else {
                    if (state is! EnableOrDisableNotificationLoadingState) {
                      NotificationCubit.get(context)
                          .enableOrDisableNotification();
                    }
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
