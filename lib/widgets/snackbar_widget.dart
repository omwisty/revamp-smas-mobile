import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType {
  info,
  success,
  warning,
  error
}

class SnackBarWidget {
  SnackBarWidget({Key? key, required this.title, required this.message, required this.type});
  final String title;
  final String message;
  SnackBarType type;

  SnackbarController show() {
    var backgroundColor = Colors.blueGrey;
    var textColor = Colors.black12;
    switch (type) {
      case SnackBarType.info:
        backgroundColor =  Colors.lightBlue;
        textColor = Colors.white;
        break;
      case SnackBarType.success:
        backgroundColor = Colors.lightGreen;
        textColor = Colors.white;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.amber;
        textColor = Colors.black87;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
    }
    return Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      borderRadius: 0,
      margin: const EdgeInsets.all(0),
      colorText: textColor,
    );
  }
}