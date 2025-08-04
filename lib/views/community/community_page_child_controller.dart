import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_classify_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPageChildController extends GetxController
    with GetTickerProviderStateMixin {
  var topics = <CommunityTopicModel>[].obs;
  late TabController tabController;
  late TabController childTabController;
  final CommunityClassifyModel model;

  CommunityPageChildController({required this.model});

  @override
  void onInit() {
    super.onInit();
    getHotTopic(model.classifyId);
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getHotTopic(int? classifyId) async {
    var result = await Api.getTopic(page: 1, pageSize: 9, classifyId: classifyId!);

    if (result != null) {
      topics.value = result;
    }
  }
}
