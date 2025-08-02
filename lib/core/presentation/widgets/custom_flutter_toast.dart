import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showFlutterToast(
    {required String message,
    required Color bgColor,
    required Color textColor}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 16.0);
}
