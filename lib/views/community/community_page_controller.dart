import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_classify_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPageController extends GetxController
    with GetTickerProviderStateMixin {
  final List<String> tags = ['推荐', '最新', '最热', '精华', '视频'];

  var tabIndex = 0.obs;
  var tabs = <CommunityClassifyModel>[].obs;
  late TabController tabController;
  late TabController childTabController;

  @override
  void onInit() {
    super.onInit();
    childTabController = TabController(length: 5, vsync: this);
    childTabController.addListener(() {
      tabIndex.value = childTabController.index;
    });
    childTabController.index = tabIndex.value;

    getCommunityClassify();
  }

  @override
  void onClose() {
    tabController.dispose();
    childTabController.removeListener(() {});
    childTabController.dispose();
    super.onClose();
  }

  Future getCommunityClassify() async {
    var result = await Api.getCommunityClassify();

    if (result != null) {
      tabs.value = result;
      tabController = TabController(length: tabs.length, vsync: this);
      update();
    }
  }

}
