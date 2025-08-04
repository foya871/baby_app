/*
 * @Author: wangdazhuang
 * @Date: 2025-02-18 21:00:57
 * @LastEditTime: 2025-03-14 16:07:58
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /years_old_16/lib/views/home/home_controller.dart
 */
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/views/home/home_forbidden/home_forbidden_logic.dart';
import 'package:baby_app/views/home/home_recommend/home_baby_logic.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../event_bus/events/events.dart';
import '../../http/api/api.dart';
import '../../model/classify/classify_models.dart';
import 'home_common/home_common_logic.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  final bool forbidden;
  int? selectedIndex; // 新增：记录当前选中的索引

  HomePageController({required this.forbidden});

  static const homeTag = "home";
  static const forbiddenTag = 'forbidden';
  static const baby = 2;

  final tabInitIndex = 0.obs;

  var stations = RxList<ClassifyModel>.empty(growable: true).obs;

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController tabController;
  StreamSubscription? classifyChangeSubs;

  final siteDomain = ''.obs;

  void changeTab(int index) {
    tabInitIndex.value = index;
  }

  @override
  void onInit() {
    final tab = Get.parameters['home_tab_index'] ?? '0';
    tabInitIndex.value = int.parse(tab);
    classifyChangeSubs = EventBusInst.listen<EditClassifyEvent>((value) {
      initStationList();
    });

    initStationList();
    super.onInit();
  }

  @override
  void onClose() {
    classifyChangeSubs?.cancel();
    super.onClose();
  }

  int get _type => forbidden == true ? 3 : 1;
  int get _classifyType => forbidden == true ? 1 : 2;

  initStationList() async {
    final res = await Api.fetchAllClassifyList(
        classifyType: _classifyType, mark: _type);
    if (res != null) {
      stations.value.clear();
      // if(!forbidden)
      // stations.value.add(
      //   ClassifyModel.fromJson(
      //     {"classifyTitle": HomePageController.baby},
      //   ),
      // );
      // stations.add(
      //   ClassifyModel.fromJson(
      //     {"classifyTitle": HomePageController.fixedTuijian},
      //   ),
      // );
      stations.value.addAll(res);
      tabController = TabController(
        length: stations.value.length,
        vsync: this,
      );
      if (stations.value.isNotEmpty) {
        for (var e in stations.value) {
          if (e.classifyType == HomePageController.baby) {
            Get.put(HomeBabyLogic(model: e));
          } else {
            if (forbidden == true) {
              Get.put(HomeForbiddenLogic(model: e), tag: e.classifyTitle);
            } else {
              Get.put(HomeCommonLogic(model: e), tag: e.classifyTitle);
            }
          }
        }
      }
    }
  }

  void switchToTabForStation(ClassifyModel station) {
    int index = stations.value.indexOf(station);
    if (index != -1 && tabController.index != index) {
      tabController.animateTo(index);
      selectedIndex = index;
    }
  }

  void toReward() {
    Get.toNamed(Routes.reward);
  }
}
