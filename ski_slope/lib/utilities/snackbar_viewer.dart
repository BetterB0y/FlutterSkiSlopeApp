import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarViewer {
  static final SnackBarViewer _instance = SnackBarViewer._();
  String _oldMessage = "";

  SnackBarViewer._();

  factory SnackBarViewer() => _instance;

  void showSnackBar(BuildContext context, String message) {
    if (_oldMessage != message) {
      _oldMessage = message;
      Flushbar(
        message: message,
        duration: const Duration(seconds: 4),
        onStatusChanged: (FlushbarStatus? status) {
          if (status == FlushbarStatus.IS_HIDING) {
            _oldMessage = "";
          }
        },
      ).show(context);
    }
  }
}
