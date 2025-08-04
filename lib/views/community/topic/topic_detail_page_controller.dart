import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicDetailPageController extends GetxController
    with GetTickerProviderStateMixin {
  var topic = ''.obs;
  var id = ''.obs;
  var tabIndex = 0.obs;
  var communityTopic = CommunityTopicModel.fromJson({}).obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    if (Get.parameters.isNotEmpty) {
      topic.value = Get.parameters['topic'] ?? '';
      id.value = Get.parameters['id'] ?? '';
      getTopicInfo(id.value);
    }

    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    tabController.index = tabIndex.value;
  }

  @override
  void onClose() {
    tabController.removeListener(() {});
    tabController.dispose();
    super.onClose();
  }

  Future getTopicInfo(String topic) async {
    final result = await Api.getTopicInfo(
      topic: topic,
    );

    if (result != null) {
      communityTopic.value = result;
    }
  }

  Future subscribe(String id, bool isSubscribe) async {
    final result = await Api.subscribe(
      id: id,
      isSubscribe: isSubscribe,
    );

    if (result) {
      communityTopic.update((data) {
        data?.subscribe = !isSubscribe;
      });
      communityTopic.refresh();
    }
  }
}
