import 'package:baby_app/components/popup/abstract_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class AbstractBottomSheet<T> extends AbstractPopup {
  final bool isDismissible;
  final Color? barrierColor;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final bool ignoreSafeArea;
  final bool isScrolledControlled;

  AbstractBottomSheet({
    this.isDismissible = true,
    this.barrierColor,
    this.backgroundColor,
    this.borderRadius = BorderRadius.zero,
    this.ignoreSafeArea = false,
    this.isScrolledControlled = false,
  });

  @override
  Future<T?> show() {
    return Get.bottomSheet(
      build(),
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      enableDrag: false,
      useRootNavigator: false,
      ignoreSafeArea: ignoreSafeArea,
      isScrollControlled: isScrolledControlled,
    );
  }
}
