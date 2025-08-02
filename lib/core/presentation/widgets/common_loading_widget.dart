import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            color: AppConstants.mainColor,
          ),
        ),
      ],
    );
  }
}
