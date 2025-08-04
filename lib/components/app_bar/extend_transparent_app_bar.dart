import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/consts.dart';

class ExtendTransparentAppBar extends AppBar {
  final bool showBack;
  final Color? backColor;
  final double? iconSize;

  ExtendTransparentAppBar({
    this.showBack = true,
    this.backColor,
    this.iconSize,
    super.key,
    super.title,
    super.centerTitle,
    super.leadingWidth,
    super.actionsIconTheme,
    super.actions,
  }) : super(
          backgroundColor: COLOR.transparent,
          surfaceTintColor: COLOR.transparent,
          shadowColor: COLOR.transparent,
          automaticallyImplyLeading: showBack,
          elevation: 0,
          leading: backColor != null
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Consts.defaultBackButtonIcon,
                    color: backColor,
                    size: iconSize,
                  ),
                )
              : null,
        );
}
