import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

extension FlushBarErrorMessage on BuildContext {
  void flushBarErrorMessage({required String message}) {
    showFlushbar(
        context: this,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          message: message,
          icon: const Icon(Icons.error),
        )..show(this));
  }
}
