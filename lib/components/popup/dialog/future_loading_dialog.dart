import '../../base_page/base_loading_widget.dart';
import 'abstract_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FutureLoadingDialog<T> extends AbstractDialog<void> {
  final Future<T>? task;
  late final Future<T> Function()? lazyTask;
  final String? tips;
  final TextStyle? tipsStyle;
  final BaseLoadingProgressController? progressController;
  // block
  // !!请勿在task中操作ui相关，只处理逻辑.
  FutureLoadingDialog(this.task,
      {this.tips, this.tipsStyle, this.progressController})
      : lazyTask = null,
        super(
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
        );

  FutureLoadingDialog.lazy(this.lazyTask,
      {this.tips, this.tipsStyle, this.progressController})
      : task = null,
        super(
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
        );

  FutureLoadingDialog.progress(
    Future<T> Function(BaseLoadingProgressController) taskBuilder, {
    this.tips,
    this.tipsStyle,
  })  : task = null,
        progressController = BaseLoadingProgressController(),
        super(
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
        ) {
    lazyTask = () => taskBuilder(progressController!);
  }

  @override
  Widget build() => BaseLoadingWidget(
        progressController: progressController,
        tips: tips,
        tipsStyle: tipsStyle,
      );

  // 不会抛出异常，异常情况将返回null
  // 如果 task 本身返回null, 则没法区分
  @override
  Future<T?> show() async {
    try {
      return await showUnsafe();
    } catch (e) {
      return null;
    }
  }

  // task可能会抛出异常
  Future<T> showUnsafe() async {
    super.show();

    try {
      if (task != null) {
        return await task!;
      }
      final t = lazyTask?.call();
      if (t == null) {
        return Future.value(null);
      }
      return await t;
    } finally {
      Get.back();
    }
  }
}
