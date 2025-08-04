import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/model/community/community_info_model.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:baby_app/views/community/widget/debounce_click.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityDetailPageController extends GetxController {
  var dynamicId = 0.obs;
  var community = CommunityModel.fromJson({}).obs;
  var community01 = CommunityModel.fromJson({}).obs;
  var community02 = CommunityModel.fromJson({}).obs;
  var ads = <AdInfoModel>[].obs;
  var communityInfoList = <CommunityInfoModel>[].obs;
  var pictures = <String>[].obs;

  TextEditingController commTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> showComm = ValueNotifier(false);
  ValueNotifier<String> defaultText = ValueNotifier('写下你的评论…');
  var params = CommentSendModel.fromJson({
    'parentId': 0,
    'topId': 0,
  }).obs;

  final debounceClick = DebounceClick(milliseconds: 1000);

  @override
  void onInit() {
    ads.value = AdUtils().getAdLoadInOrder(AdApiType.INSERT_ICON);
    super.onInit();
    if (Get.parameters.isNotEmpty) {
      dynamicId.value = int.tryParse(Get.parameters['dynamicId'] ?? '') ?? 0;
      getDynamicInfo(dynamicId.value);
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showComm.value = true;
      } else {
        showComm.value = false;
      }
    });
  }

  @override
  void onClose() {
    focusNode.dispose();
    commTextController.dispose();
    super.onClose();
  }

  void refreshWithNewId(int newId) {
    dynamicId.value = newId;
    communityInfoList.clear();
    pictures.clear();
    getDynamicInfo(dynamicId.value);
  }

  Future getDynamicInfo(int dynamicId) async {
    final result = await Api.getDynamicInfo(
      dynamicId: dynamicId,
    );

    if (result != null) {
      community.value = result;

      if (community.value.topDynamicAll != null) {
        community01.value = community.value.topDynamicAll!;
      }
      if (community.value.underDynamicAll != null) {
        community02.value = community.value.underDynamicAll!;
      }
      if (community.value.contentText != null &&
          community.value.contentText != '') {
        communityInfoList.add(
            CommunityInfoModel.addText(0, community.value.contentText ?? ''));
      }

      if (community.value.images != null) {
        for (final image in community.value.images!) {
          communityInfoList.add(CommunityInfoModel.addImage(1, image));
          pictures.add(image);
        }
      }

      if (community.value.video != null) {
        communityInfoList
            .add(CommunityInfoModel.addVideo(2, community.value.video!));
      }
    }
  }

  Future communityAttention(int toUserId, bool isAttention) async {
    final result = await Api.communityAttention(
      toUserId: toUserId,
      isAttention: isAttention,
    );

    if (result) {
      community.update((data) {
        data?.attention = !isAttention;
      });
      community.refresh();
    }
  }

  Future communityPraise(int dynamicId, bool isLike) async {
    final result = await Api.communityPraise(
      dynamicId: dynamicId,
      isLike: isLike,
    );

    if (result) {
      int fakeLikes = community.value.fakeLikes ?? 0;
      if (isLike) {
        fakeLikes = fakeLikes - 1;
      } else {
        fakeLikes = fakeLikes + 1;
      }
      bool like = community.value.isLike ?? false;
      community.update((data) {
        data?.isLike = !like;
        data?.fakeLikes = fakeLikes;
      });
      community.refresh();
    }
  }

  Future communityFavorite(int dynamicId, bool isFavorite) async {
    final result = await Api.communityFavorite(
      dynamicId: dynamicId,
      isFavorite: isFavorite,
    );

    if (result) {
      int fakeFavorites = community.value.fakeFavorites ?? 0;
      if (isFavorite) {
        fakeFavorites = fakeFavorites - 1;
      } else {
        fakeFavorites = fakeFavorites + 1;
      }
      community.update((data) {
        data?.isFavorite = !isFavorite;
        data?.fakeFavorites = fakeFavorites;
      });
      community.refresh();
    }
  }

  Future handleComment() async {
    params.value.dynamicId = community.value.dynamicId;
    params.value.content = commTextController.text;
    if (params.value.content!.isEmpty) {
      EasyToast.show('评论内容不能为空');
      return;
    }

    debounceClick.run(() async {
      final result = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.communitySaveComment(model: params.value);
        },
      );

      if (result) {
        params.value = CommentSendModel.fromJson({
          'parentId': 0,
          'topId': 0,
        });
        EasyToast.show('评论成功,请等待审核!');
      }
      params.value.img = null;
      commTextController.text = '';
      defaultText.value = '写下你的评论…';
      focusNode.unfocus();
    });
  }
}
