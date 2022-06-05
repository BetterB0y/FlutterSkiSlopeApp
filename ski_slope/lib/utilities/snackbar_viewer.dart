import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/resources/durations.dart';

class SnackBarViewer {
  static final SnackBarViewer _instance = SnackBarViewer._();
  String _oldMessage = "";

  SnackBarViewer._();

  factory SnackBarViewer() => _instance;

  Future<void> showSnackBar(BuildContext context, String message) async {
    if (_oldMessage != message) {
      _oldMessage = message;
      Flushbar(
        message: message,
        duration: Durations.snackBarShowingDuration,
        onStatusChanged: (FlushbarStatus? status) {
          if (status == FlushbarStatus.IS_HIDING) {
            _oldMessage = "";
          }
        },
      ).show(context);
      await Future.delayed(Durations.snackBarShowingDuration, () => _oldMessage = "");
    }
  }
}
