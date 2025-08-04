import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardContainerController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  List<String> tabs = RxList<String>.empty(growable: true);

  @override
  void onInit() {
    getType();
    super.onInit();
  }

  void getType() {
    tabs.assignAll(["福利任务", "应用推荐"]);
    tabController = TabController(length: tabs.length, vsync: this);
    update();
  }
}
