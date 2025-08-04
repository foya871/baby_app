import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../generate/app_image_path.dart';
import '../../../services/user_service.dart';
import '../../../utils/enum.dart';

class AiHomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const tabs = [
    Tuple2(AppImagePath.ai_tab_cloth_y, AppImagePath.ai_tab_cloth),
    Tuple2(AppImagePath.ai_tab_face_image_y, AppImagePath.ai_tab_face_image),
    Tuple2(AppImagePath.ai_tab_face_video_y, AppImagePath.ai_tab_face_video),
    // Tuple2(AppImagePath.ai_tab_face_custom_y, AppImagePath.ai_tab_face_custom),
  ];
  static const tabClothIndex = 0;
  static const tabFaceImageIndex = 1;
  static const tabFaceVideoIndex = 2;
  // static const tabFaceCustomIndex = 3;

  static const tabDefaultIndex = tabClothIndex;

  static int getTabIndexByTabName(AiTabName? tab) {
    return switch (tab) {
      AiTabNameEnum.cloth => tabClothIndex,
      AiTabNameEnum.faceImage => tabFaceImageIndex,
      AiTabNameEnum.faceVideo => tabFaceVideoIndex,
      // AiTabNameEnum.faceCustom => tabFaceCustomIndex,
      _ => tabDefaultIndex,
    };
  }

  late final TabController tabController;

  final currentIndex = tabDefaultIndex.obs;

  void onChangeTabIndex(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  void changeToIndexByTabName(AiTabName? tab) {
    final index = getTabIndexByTabName(tab);
    onChangeTabIndex(index);
  }

  @override
  void onInit() {
    final tab = Get.parameters['tab'] ?? '';
    final index = getTabIndexByTabName(tab);
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: index);
    onChangeTabIndex(index);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      onChangeTabIndex(tabController.index);
    });

    Get.find<UserService>().updateAll();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
