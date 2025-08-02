import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import 'logic/notification_cubit.dart';
import 'logic/notification_states.dart';
import 'notification_item.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = NotificationCubit.get(context);
    notificationCubit.getNotificationList();
    notificationCubit.scrollController = ScrollController();
    notificationCubit.scrollController.addListener(
      () {
        notificationCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblNotification,
        customActionWidget: BlocConsumer<NotificationCubit, NotificationStates>(
          listener: (BuildContext notificationCtx,
              NotificationStates notificationState) {},
          builder: (BuildContext notificationCtx,
                  NotificationStates notificationState) =>
              notificationState is NotificationLoadingState ||
                      notificationState is NotificationErrorState
                  ? const SizedBox()
                  : InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        if (notificationState is! NotificationEmptyState) {
                          notificationCubit.clearAllNotificationList();
                        }
                      },
                      child: SizedBox(
                        width: getWidgetWidth(60),
                        height: getWidgetHeight(30),
                        child: Center(
                          child: CommonTitleText(
                            textKey: AppLocalizations.of(context)!.lblClearAll,
                            textWeight: FontWeight.w600,
                            textFontSize: AppConstants.fontSize14,
                            minTextFontSize: AppConstants.fontSize14,
                            textColor:
                                notificationState is NotificationEmptyState
                                    ? AppConstants.lightGrayColor
                                    : AppConstants.lightRedColor,
                          ),
                        ),
                      ),
                    ),
        ),
      ),
      body: BlocConsumer<NotificationCubit, NotificationStates>(listener:
          (BuildContext notificationCtx, NotificationStates notificationState) {
        if (notificationState is NotificationErrorState) {
          // checkUserAuth(
          //     context: notificationCtx,
          //     errorType: notificationState.error!.type);
        } else if (notificationState is ClearNotificationSuccessState) {
          notificationCubit.getNotificationList();
        } else if (notificationState is DeleteNotificationErrorState) {
          showSnackBar(
              context: notificationCtx,
              title: notificationState.error!.type.getErrorMessage(context) ??
                  notificationState.error!.errorMassage);
        } else if (notificationState is ReadNotificationErrorState) {
          showSnackBar(
              context: notificationCtx,
              title: notificationState.error!.type.getErrorMessage(context) ??
                  notificationState.error!.errorMassage);
        }
      }, builder:
          (BuildContext notificationCtx, NotificationStates notificationState) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.padding8)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (notificationState is NotificationLoadingState) ...<Widget>[
                  const Expanded(child: CommonLoadingWidget())
                ] else if (notificationState
                    is NotificationErrorState) ...<Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CommonError(
                          errorType: notificationState.error!.type,
                          withButton: true,
                          onTap: () => notificationCubit.getNotificationList(),
                        ),
                      ],
                    ),
                  )
                ] else if (notificationState is NotificationEmptyState ||
                    notificationCubit.notificationList.isEmpty) ...<Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        getSpaceHeight(42),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonAssetSvgImageWidget(
                              imageString: IconPath.emptyIcon,
                              height: 210,
                              width: 300,
                            )
                          ],
                        ),
                        getSpaceHeight(42),
                        CommonTitleText(
                            textKey:
                                AppLocalizations.of(context)!.lblNoNotification,
                            textColor: AppConstants.mainColor,
                            textFontSize: AppConstants.fontSize20,
                            minTextFontSize: AppConstants.fontSize20,
                            textWeight: FontWeight.w500)
                      ],
                    ),
                  )
                ] else ...<Widget>[
                  ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: getWidgetHeight(AppConstants.padding16)),
                    shrinkWrap: true,
                    controller: notificationCubit.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: notificationCubit.notificationList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return getSpaceHeight(AppConstants.padding8);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          NotificationItem(
                            model: notificationCubit.notificationList[index],
                          ),
                          if (index >=
                                  notificationCubit.notificationList.length &&
                              notificationCubit.hasMoreData)
                            const CommonLoadingWidget()
                          else
                            const SizedBox()
                        ],
                      );
                    },
                  )
                ]
              ]),
        );
      }),
    );
  }
}
