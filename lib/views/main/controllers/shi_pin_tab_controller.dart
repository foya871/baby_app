/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 13:58:01
 * @LastEditTime: 2025-02-25 09:44:13
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/main/controllers/shi_pin_tab_controller.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baby_app/model/classify/classify_models.dart';

import '../../../services/app_service.dart';

class ShiPinTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  late final List<ClassifyModel> tabs;

  @override
  void onInit() {
    tabs = Get.find<AppService>().shiPinTabs;
    int initialIndex = 0;

    tabController = TabController(
      length: tabs.length,
      initialIndex: initialIndex,
      vsync: this,
    );

    super.onInit();
  }
}
