import 'package:baby_app/utils/extension.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeRewardController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  List<String> tabs = ['代理赚钱', '福利任务', '应用推荐'];

  @override
  void onInit() {
    tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: tabIndex.value);
    tabController.addStableListener((index) {
      tabIndex.value = index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
