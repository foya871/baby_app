import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_release_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:baby_app/model/community/community_video_model.dart';
import 'package:baby_app/views/community/widget/debounce_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityReleasePageController extends GetxController
    with GetTickerProviderStateMixin {
  var topics01 = <CommunityTopicModel>[].obs;
  var topics02 = <CommunityTopicModel>[].obs;
  var communityRelease = CommunityReleaseModel.fromJson({}).obs;
  var communityRelease02 = CommunityReleaseModel.fromJson({}).obs;
  var video = CommunityVideoModel.fromJson({}).obs;
  var video02 = CommunityVideoModel.fromJson({}).obs;
  var selectedNum = 0.obs;
  var selectedNum02 = 0.obs;

  late TabController tabController = TabController(length: 2, vsync: this);

  TextEditingController contentEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final int maxLength = 500;

  TextEditingController contentEditingController2 = TextEditingController();
  FocusNode focusNode2 = FocusNode();
  final int maxLength2 = 500;

  TextEditingController priceEditingController = TextEditingController();
  FocusNode priceFocusNode = FocusNode();
  var priceInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  final debounceClick = DebounceClick(milliseconds: 1000);

  @override
  void onInit() {
    super.onInit();
    getCommunityTopic();
  }

  @override
  void onClose() {
    tabController.dispose();
    focusNode.dispose();
    contentEditingController.dispose();
    focusNode2.dispose();
    contentEditingController2.dispose();
    priceFocusNode.dispose();
    priceEditingController.dispose();
    super.onClose();
  }

  Future getCommunityTopic() async {
    final result = await Api.getCommunityTopic();

    if (result != null) {
      topics01.value = result.map((e) => e.copy()).toList();
      topics02.value = result.map((e) => e.copy()).toList();
    }
  }

  Future notifyChanged(int index) async {
    if (topics01.isNotEmpty) {
      if (topics01[index].selected == true) {
        topics01[index].selected = false;
        topics01.refresh();
        return;
      }

      var list = <CommunityTopicModel>[];
      for (int i = 0; i < topics01.length; i++) {
        if (topics01[i].selected == true) {
          list.add(topics01[i]);
        }
      }

      selectedNum.value = list.length;

      if (selectedNum >= 1) {
        EasyToast.show('最多选择1个话题');
        return;
      }

      topics01[index].selected = !topics01[index].selected!;
      topics01.refresh();
    }
  }

  Future notifyChanged02(int index) async {
    if (topics02.isNotEmpty) {
      if (topics02[index].selected == true) {
        topics02[index].selected = false;
        topics02.refresh();
        return;
      }

      var list = <CommunityTopicModel>[];
      for (int i = 0; i < topics02.length; i++) {
        if (topics02[i].selected == true) {
          list.add(topics02[i]);
        }
      }

      selectedNum02.value = list.length;

      if (selectedNum02 >= 1) {
        EasyToast.show('最多选择1个话题');
        return;
      }

      topics02[index].selected = !topics02[index].selected!;
      topics02.refresh();
    }
  }

  Future addImages(List<String> images) async {
    communityRelease.value.images = images;
  }

  Future addImages02(List<String> images) async {
    communityRelease02.value.images = images;
  }

  Future addVideo(Map map) async {
    video.value.id = map["id"];
    video.value.playTime = map["playTime"];
    video.value.videoUrl = map["uri"];
    video.value.title = map["title"];
    communityRelease.value.video = video.value;
  }

  Future addVideo02(Map map) async {
    video02.value.id = map["id"];
    video02.value.playTime = map["playTime"];
    video02.value.videoUrl = map["uri"];
    video02.value.title = map["title"];
    communityRelease02.value.video = video02.value;
  }

  Future release() async {
    if (contentEditingController.text.isEmpty) {
      EasyToast.show('请输入帖子内容');
      return;
    }

    if (communityRelease.value.images == null) {
      EasyToast.show('请选择图片');
      return;
    }

    var list = <String>[];
    if (topics01.isNotEmpty) {
      for (int i = 0; i < topics01.length; i++) {
        if (topics01[i].selected == true) {
          list.add(topics01[i].name ?? '');
        }
      }
    }
    if (list.isEmpty) {
      EasyToast.show('请选择话题');
      return;
    }

    communityRelease.value.dynamicType = 1;
    communityRelease.value.title = '';
    communityRelease.value.contentText = contentEditingController.text;
    communityRelease.value.topics = list;

    debounceClick.run(() async {
      final result = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.communityRelease(model: communityRelease.value);
        },
      );

      if (result) {
        EasyToast.show('发布成功');
        Get.back();
      }
    });
  }

  Future release02() async {
    if (contentEditingController2.text.isEmpty) {
      EasyToast.show('请输入帖子内容');
      return;
    }

    if (communityRelease02.value.images == null) {
      EasyToast.show('请选择图片');
      return;
    }

    if (communityRelease02.value.video == null) {
      EasyToast.show('请选择视频');
      return;
    }

    var list = <String>[];
    if (topics02.isNotEmpty) {
      for (int i = 0; i < topics02.length; i++) {
        if (topics02[i].selected == true) {
          list.add(topics02[i].name ?? '');
        }
      }
    }
    if (list.isEmpty) {
      EasyToast.show('请选择话题');
      return;
    }

    if (priceEditingController.text.isNotEmpty) {
      communityRelease02.value.price =
          double.tryParse(priceEditingController.text) ?? 0.0;
    }

    communityRelease02.value.dynamicType = 2;
    communityRelease02.value.contentText = contentEditingController2.text;
    communityRelease02.value.topics = list;

    debounceClick.run(() async {
      final result = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.communityRelease(model: communityRelease02.value);
        },
      );

      if (result) {
        EasyToast.show('发布成功');
        Get.back();
      }
    });
  }
}
