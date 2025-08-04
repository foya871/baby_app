import 'package:baby_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../http/api/api.dart';
import '../../../model/video_base_model.dart';
import '../../../services/storage_service.dart';
import '../../../utils/enum.dart';

class SearchResultVideoController
    extends BaseRefreshSimpleController<VideoBaseModel>
    with GetTickerProviderStateMixin {
  final service = Get.find<StorageService>();
  final _pageSize = 20;
  String keyWord = "";
  late TabController tabController;

  //视频tab
  late TabController videoTabController;
  var videoTabs = ["全部"].obs;
  var videoTabIndex = 0.obs;

  var showFilter = false.obs;
  var searchType = SearchType.video;
  var videoRuleType = VideoRuleType.complex;
  var filterVideoLongType = FilterVideoLongType.noLimit;

  @override
  bool get useObs => true;

  @override
  void onInit() {
    keyWord = Get.arguments['keyWord'];
    videoTabController = TabController(length: videoTabs.length, vsync: this);
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    startToSearch(keyWord);
    _initStationList();
  }

  startToSearch(String key) {
    if (key.isEmpty) {
      return;
    }
    keyWord = key;
    onRefresh();
  }

  _initStationList() async {
    final res = await Api.fetchAllClassifyList(classifyType: 1, mark: 1);
    if (res != null) {
      for (var item in res) {
        videoTabs.add(item.classifyTitle);
      }
      tabController = TabController(length: videoTabs.length, vsync: this);
    }
  }

  Future<List<VideoBaseModel>?> getSearchResult({
    required int page,
  }) async {
    var resultModel = await Api.searchKey(
      searchType: searchType,
      searchWord: keyWord,
      page: page,
      pageSize: _pageSize,
      classifyTitle:
          videoTabIndex.value != 0 ? videoTabs[videoTabIndex.value] : "",
      sortMark: videoRuleType.type,
      startPlayTime: filterVideoLongType.startDuration,
      endPlayTime: filterVideoLongType.endDuration,
    );
    debugPrint("resultModel?.videoList = ${resultModel?.videoList}");
    return resultModel?.videoList ?? [];
  }

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return getSearchResult(page: page);
  }

  @override
  bool noMoreChecker(List<VideoBaseModel> resp) {
    return resp.length < _pageSize;
  }

  void toVideo(int? videoId) {
    Get.toPlayVideo(videoId: videoId ?? 0);
  }
}
