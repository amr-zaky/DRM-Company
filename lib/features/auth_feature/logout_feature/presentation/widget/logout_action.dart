import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../logic/logout_cubit/logout_cubit.dart';
import '../logic/logout_cubit/logout_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/Alert_Dialogs/alert_dialog_with_two_buttons.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/common_waiting_dialog_widget.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';

class LogoutAction extends StatelessWidget {
  const LogoutAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutStates>(
      listener: (BuildContext context, LogoutStates state) {
        if (state is UserLogoutLoadingState) {
          showWaitingDialog(context);
        } else if (state is UserLogOutErrorState) {
          context.pop();
          showSnackBar(
              context: context,
              title: state.error!.type.getErrorMessage(context) ??
                  state.error!.errorMassage,
              color: AppConstants.lightRedColor);
          // checkUserAuth(context: context, errorType: state.error!.type);
        } else if (state is UserLogoutSuccessState) {
          context.pushReplacementNamed(RouteNames.loginHomePageRoute);
        }
      },
      builder: (BuildContext context, LogoutStates state) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            showAlertDialogWithTwoButton(
              context: context,
              title: AppLocalizations.of(context)!.lblLogOut,
              description: AppLocalizations.of(context)!.lblSureToLogout,
              firstButtonText: AppLocalizations.of(context)!.lblYes,
              secondButtonText: AppLocalizations.of(context)!.lblBack,
              firstButtonOnTap: (BuildContext ctx) {
                ctx.pop();

                context.read<LogoutCubit>().logOut();
              },
              secondButtonOnTap: (BuildContext ctx) => ctx.pop(),
              titleTextColor: AppConstants.lightRedColor,
              isFirstButtonLoading: state is UserLogoutLoadingState,
              imagePath: IconPath.logOutIcon,

              imageHeight: 95.92,
              imageWidth: 105.97,
            );
          },
          child: Container(
            height: getWidgetHeight(48),
            width: SharedText.screenWidth,
            padding: const EdgeInsets.all(AppConstants.padding8),
            decoration:
                const BoxDecoration(color: AppConstants.lightOffWhiteColor),
            child: Row(
              children: <Widget>[
                /// Icon
                const CommonAssetSvgImageWidget(
                  imageString: IconPath.logOutIcon,
                  height: 16,
                  width: 16,
                  imageColor: AppConstants.appBarTitleColor,
                ),
                getSpaceWidth(8),

                /// Title
                CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblLogOut,
                    textColor: AppConstants.appBarTitleColor,
                    textFontSize: AppConstants.fontSize14,
                    minTextFontSize: AppConstants.fontSize14,
                    textWeight: FontWeight.w500),
              ],
            ),
          ),
        );
      },
    );
  }
}
