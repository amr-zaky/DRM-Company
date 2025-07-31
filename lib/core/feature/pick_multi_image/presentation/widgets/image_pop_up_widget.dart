import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';

Widget imageDialog(String path, BuildContext context, {bool? isFile = false}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    insetPadding: const EdgeInsets.symmetric(horizontal: 18),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 16,
              splashRadius: 15,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel_outlined),
              color: AppConstants.lightWhiteColor,
            ),
          ],
        ),
        if (isFile!)
          SizedBox(
            height: getWidgetHeight(278.2),
            width: getWidgetWidth(335.84),
            child: PhotoView(
              imageProvider: FileImage(
                File(path),
              ),
              enableRotation: true,
            ),
          )
        else
          SizedBox(
            height: getWidgetHeight(278.2),
            width: getWidgetWidth(335.84),
            child: PhotoView(
              imageProvider: NetworkImage(path),
              enableRotation: true,
            ),
          ),
      ],
    ),
  );
}
