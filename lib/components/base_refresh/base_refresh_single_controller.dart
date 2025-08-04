import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// getx 加入单个 refresh controller

abstract class BaseRefreshSingleContronller extends GetxController {
  final refreshController = EasyRefreshController();
  ScrollController? _scrollController;

  ScrollController get scrollController =>
      _scrollController ??= ScrollController();

  @override
  void onClose() {
    refreshController.dispose();
    _scrollController?.dispose();
    super.onClose();
  }
}
