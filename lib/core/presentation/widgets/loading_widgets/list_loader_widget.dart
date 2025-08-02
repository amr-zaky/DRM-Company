import 'package:flutter/cupertino.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import 'scale_transition_loader_widget.dart';

class ListLoaderWidget extends StatelessWidget {
  const ListLoaderWidget({
    Key? key,
    this.direction = Axis.vertical,
    this.itemCount = 5,
    this.itemHeight = 40,
    this.itemWidth = 300,
    this.itemRadius = AppConstants.borderRadius8,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  final Axis? direction;
  final int? itemCount;
  final double itemHeight;
  final double itemWidth;
  final double itemRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: padding,
        physics: const BouncingScrollPhysics(),
        scrollDirection: direction!,
        itemBuilder: (BuildContext context, int index) {
          return LoadingShimmer(
            height: itemHeight,
            width: itemWidth,
            radius: itemRadius,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return direction == Axis.vertical
              ? getSpaceHeight(AppConstants.padding8)
              : getSpaceWidth(AppConstants.padding8);
        },
        itemCount: itemCount!);
  }
}
