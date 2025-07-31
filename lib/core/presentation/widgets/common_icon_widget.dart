import 'package:flutter/material.dart';

class CommonIconWidget extends StatelessWidget {
  const CommonIconWidget(
      {Key? key,
      required this.iconData,
      required this.color,
      required this.mobileSize,
      this.onTapIcon})
      : super(key: key);
  final IconData iconData;
  final Color color;
  final double mobileSize;
  final Function()? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapIcon,
      child: Icon(iconData, color: color, size: mobileSize),
    );
  }
}
