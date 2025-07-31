import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';

class ChatLoaderWidget extends StatelessWidget {
  const ChatLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.padding16),
              vertical: getWidgetHeight(AppConstants.padding16)),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: index.isEven
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: <Widget>[
                LoadingShimmer(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.45,
                  radius: AppConstants.borderRadius15,
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return getSpaceHeight(AppConstants.padding8);
          },
          itemCount: 12),
    );
  }
}
