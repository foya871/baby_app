import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../abstract_popup.dart';

abstract class AbstractDialog<T> extends AbstractPopup {
  final bool barrierDismissible;
  final Color? barrierColor;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final bool blur;

  AbstractDialog({
    this.barrierDismissible = true,
    this.barrierColor,
    this.backgroundColor,
    this.borderRadius = BorderRadius.zero,
    this.blur = false,
  });

  @override
  Future<T?> show() {
    final container = AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      content: build(),
    );
    Widget body = container;
    if (blur) {
      body = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: container,
      );
    }
    return Get.dialog(
      body,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }
}
