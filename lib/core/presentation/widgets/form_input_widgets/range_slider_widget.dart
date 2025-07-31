import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class RangeSliderWidget extends StatefulWidget {
  const RangeSliderWidget(
      {super.key,
      required this.onChanged,
      required this.values,
      required this.labels});
  final Function(RangeValues) onChanged;
  final RangeLabels labels;
  final RangeValues values;

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        rangeThumbShape: const CustomThumbShape(),
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: AppConstants.mainColor,
        valueIndicatorTextStyle:
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppConstants.lightWhiteColor,
                  fontSize: AppConstants.fontSize10,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
        trackHeight: 3,
      ),
      child: RangeSlider(
          divisions: 100,
          activeColor: AppConstants.mainTextColor,
          inactiveColor: AppConstants.lightGrayColor,
          min: 1,
          max: 100,
          values: widget.values,
          labels: widget.labels,
          onChanged: widget.onChanged),
    );
  }
}

class CustomThumbShape implements RangeSliderThumbShape {
  const CustomThumbShape({
    this.radius = 10.0,
    this.ringColor = AppConstants.mainColor,
  });

  /// Outer radius of thumb

  final double radius;

  /// Color of ring

  final Color ringColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    // To create a ring create outer circle and create an inner cicrle then
    // subtract inner circle from outer circle and you will get a ring shape
    // fillType = PathFillType.evenOdd will be used for that

    final Path path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    // ..addOval(Rect.fromCircle(center: center, radius: radius - 5))
    // ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, Paint()..color = ringColor);
  }
}
