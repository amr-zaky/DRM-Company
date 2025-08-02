import 'dart:io';
import 'package:flutter/material.dart';
import '../../helpers/shared.dart';

class CommonFileImageWidget extends StatelessWidget {
  const CommonFileImageWidget({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
    this.radius = 0.0,
    this.fit = BoxFit.fill,
  }) : super(key: key);
  final String imagePath;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: Image.file(
        File(imagePath),
        fit: fit,
        height: getWidgetHeight(height),
        width: getWidgetHeight(height),
      ),
    );
  }
}
