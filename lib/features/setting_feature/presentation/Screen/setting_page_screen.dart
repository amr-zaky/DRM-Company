import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_argument.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_error_widget.dart';
import '../../../../core/presentation/widgets/common_loading_widget.dart';
import '../logic/setting_cubit/setting_cubit.dart';
import '../logic/setting_cubit/setting_cubit_states.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key, required this.routeArgument});
  final RouteArgument routeArgument;

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
  @override
  void initState() {
    super.initState();
    SettingCubit.get(context)
        .getSettingPageContent(widget.routeArgument.pageType!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: widget.routeArgument.pageTitle!,
      ),
      body: BlocConsumer<SettingCubit, SettingCubitState>(
          listener:
              (BuildContext sittingCtx, SettingCubitState sittingState) {},
          builder: (BuildContext sittingCtx, SettingCubitState sittingState) {
            if (sittingState is SettingFailedState) {
              return CommonError(
                errorMassage: sittingState.error.errorMassage,
                withButton: true,
                errorType: sittingState.error.type,
                onTap: () {
                  SettingCubit.get(context)
                      .getSettingPageContent(widget.routeArgument.pageType!);
                },
              );
            } else if (sittingState is SettingLoadingState) {
              return const CommonLoadingWidget();
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.all(getWidgetHeight(AppConstants.padding16)),
                  child: RichText(
                    text: HTML.toTextSpan(
                      context,
                      sittingCtx.read<SettingCubit>().pageContent,
                      defaultTextStyle:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppConstants.mainTextColor,
                                fontSize: AppConstants.fontSize12,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.visible,
                              ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
