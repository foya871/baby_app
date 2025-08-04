import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../assets/styles.dart';
import 'abstract_dialog.dart';
import '../../easy_button.dart';
import '../../../utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseConfirmDialog<T> extends AbstractDialog<T> {
  ///
  final String? titleText;
  final TextStyle? titleStyle;
  final Widget? titleWidget;

  ///
  final String? descText;
  final TextStyle? descStyle;
  final Widget? descWidget;

  ///
  final String? cancelText;
  final TextStyle? cancelStyle;
  final Color? cancelBgColor;
  final VoidCallback? onCancel;
  final bool autoBackOnCancel;
  final BorderRadius? cancelBorderRadius;

  ///
  final String? confirmText;
  final TextStyle? confirmStyle;
  final Color? confirmBgColor;
  final VoidCallback? onConfirm;
  final bool autoBackOnConfirm;
  final BorderRadius? confirmBorderRadius;

  BaseConfirmDialog(
      {super.barrierDismissible,
      super.barrierColor,
      super.blur = true,
      this.titleText,
      this.titleStyle,
      this.titleWidget,
      this.descText,
      this.descStyle,
      this.descWidget,
      this.cancelText,
      this.cancelStyle,
      this.cancelBgColor,
      this.cancelBorderRadius,
      this.onCancel,
      this.autoBackOnCancel = true,
      this.confirmText,
      this.confirmStyle,
      this.onConfirm,
      this.confirmBgColor,
      this.autoBackOnConfirm = true,
      this.confirmBorderRadius})
      : super(
          backgroundColor: COLOR.color_1E1E1E,
          borderRadius: Styles.borderRaidus.l,
        );

  Widget? _buildTitle() {
    if (titleWidget != null) {
      return titleWidget!;
    }
    if (titleText == null || titleText!.isEmpty) {
      return null;
    }
    final defaultStyle = TextStyle(
      fontSize: 16.w,
      fontWeight: FontWeight.w500,
    );
    return Text(titleText!, style: titleStyle ?? defaultStyle);
  }

  Widget? _buildDesc() {
    if (descWidget != null) {
      return descWidget!;
    }
    if (descText == null || descText!.isEmpty) {
      return null;
    }
    final defaultStyle = TextStyle(
      fontSize: 15.w,
      color: COLOR.primaryText.withValues(alpha: 0.7),
      fontWeight: FontWeight.w500,
    );
    return Text(descText!, style: descStyle ?? defaultStyle);
  }

  Widget? _buildCancel() {
    if (cancelText == null || cancelText!.isEmpty) {
      return null;
    }
    final defaultStyle = TextStyle(
      fontSize: 16.w,
      color: COLOR.white.withValues(alpha: 0.8),
    );
    return EasyButton(
      cancelText!,
      width: 120.w,
      height: 40.w,
      textStyle: cancelStyle ?? defaultStyle,
      backgroundColor: cancelBgColor ?? COLOR.white.withValues(alpha: 0.15),
      // borderColor: COLOR.themeSelectedColor,
      // borderWidth: 1.5,
      borderRadius: cancelBorderRadius ?? Styles.borderRaidus.all(20.5.w),
      onTap: () {
        if (autoBackOnCancel) {
          Get.back();
        }
        onCancel?.call();
      },
    );
  }

  Widget? _buildConfirm() {
    if (confirmText == null || confirmText!.isEmpty) {
      return null;
    }
    final defaultStyle = TextStyle(
      fontSize: 15.w,
      color: COLOR.white,
      fontWeight: FontWeight.w500,
    );
    return EasyButton(
      confirmText!,
      width: 120.w,
      height: 40.w,
      textStyle: confirmStyle ?? defaultStyle,
      backgroundColor: COLOR.themeSelectedColor,
      borderRadius: confirmBorderRadius ?? Styles.borderRaidus.all(18.5.w),
      onTap: () {
        if (autoBackOnConfirm) {
          Get.back();
        }
        onConfirm?.call();
      },
    );
  }

  @override
  Widget build() {
    final title = _buildTitle();
    final desc = _buildDesc();
    final cancel = _buildCancel();
    final confirm = _buildConfirm();
    final children = <Widget>[];
    if (title != null) {
      children.add(title);
    }
    if (desc != null) {
      children.add(SizedBox(height: 6.w));
      children.add(desc.marginHorizontal(20.w));
    }

    final rowChildren = <Widget>[];
    if (cancel != null) rowChildren.add(cancel);
    if (confirm != null) rowChildren.add(confirm);
    if (rowChildren.isNotEmpty) {
      children.add(SizedBox(height: 33.w));
      final mainAlignment = rowChildren.length == 2
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center;
      children.add(
        Row(mainAxisAlignment: mainAlignment, children: rowChildren)
            .marginHorizontal(16.w),
      );
    }

    return Container(
      width: 286.w,
      decoration: BoxDecoration(
        color: COLOR.color_13141F,
        borderRadius: Styles.borderRadius.all(12.w),
      ),
      padding: EdgeInsets.only(top: 44.w, bottom: 25.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
