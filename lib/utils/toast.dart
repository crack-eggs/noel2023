import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class AppToast{
  static void showError(String message){
    Fluttertoast.showToast(
        msg:
        message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        webBgColor: colorToastError,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void show(String message){
    Fluttertoast.showToast(
        msg:
        message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        webBgColor: colorToastError,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}