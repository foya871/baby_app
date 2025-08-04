import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/routes/routes.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_topic_model.dart';
import '../../../model/search/same_city_model.dart';
import '../../../model/search/search_result_model.dart';
import '../../../model/search/search_topic_model.dart';
import '../../../model/search/search_video_result_model.dart';
import '../../../services/storage_service.dart';
import '../../../utils/enum.dart';

class SearchResultTopicController
    extends BaseRefreshSimpleController<CommunityTopicModel>
    with GetTickerProviderStateMixin {
  final service = Get.find<StorageService>();
  final _pageSize = 20;
  String keyWord = "";

  var searchType = SearchType.topic;

  @override
  bool get useObs => true;

  @override
  void onInit() {
    keyWord = Get.arguments['keyWord'];
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    startToSearch(keyWord);
  }

  startToSearch(String key) {
    if (key.isEmpty) {
      return;
    }
    keyWord = key;
    onRefresh();
  }

  Future<List<CommunityTopicModel>?> getSearchResult({
    required int page,
  }) async {
    var resultModel = await Api.searchKey(
      searchType: searchType,
      searchWord: keyWord,
      page: page,
      pageSize: _pageSize,
    );
    debugPrint("resultModel?.topicList = ${resultModel?.topicList}");
    return resultModel?.topicList ?? [];
  }

  @override
  Future<List<CommunityTopicModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return getSearchResult(page: page);
  }

  @override
  bool noMoreChecker(List<CommunityTopicModel> resp) {
    return resp.length < _pageSize;
  }

  void toVideo(int? videoId) {
    Get.toPlayVideo(videoId: videoId ?? 0);
  }
}
