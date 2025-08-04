import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../components/base_refresh/base_refresh_share_tab_controller.dart';
import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../http/api/api.dart';
import '../../../model/tags_model.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';

const _pageSize = 60;
const _useObs = true;
const _sortMaskMostPlayed = 1;
const _sortMaskMostFav = 2;
const _sortMaskLatest = 3;
const _videoTypeVip = 1;
const _videoTypePay = 2;

class _DataKeeper
    extends BaseRefreshDataKeeperWithScrollOffset<VideoBaseModel> {
  final int? sortMark;
  final String? tagsTitle;
  final int? videoType;

  _DataKeeper({
    required this.sortMark,
    required this.tagsTitle,
    required this.videoType,
  });

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.fetchVideoHouse(
      page: page,
      pageSize: _pageSize,
      sortMark: sortMark,
      tagsTitle: tagsTitle,
      videoType: videoType,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}

class VideoBoxPageController extends BaseRefreshShareTabController
    with StateMixin, GetTickerProviderStateMixin {
  VideoBoxPageController() : super(enableJump: false);

  static const markTabs = <Tuple2<String, int?>>[
    Tuple2('综合排序', null),
    Tuple2('播放最多', _sortMaskMostPlayed),
    Tuple2('收藏最多', _sortMaskMostFav),
    Tuple2('最新上架', _sortMaskLatest),
  ];
  static int? getSortMarkByIndex(int index) => markTabs[index].item2;

  static const videoTypeTabs = <Tuple2<String, int?>>[
    Tuple2('综合类型', null),
    Tuple2('金币', _videoTypePay),
    Tuple2('VIP', _videoTypeVip),
  ];
  static int? getVideoTypeByIndex(int index) => videoTypeTabs[index].item2;

  final tagTabs = <TagsModel>[];
  String? getTagsTitleByIndex(int index) {
    final tag = tagTabs[index];
    if (tag.isAll) return null;
    return tag.tagsTitle;
  }

  final layout = VideoLayout.big.obs;

  late final TabController markTabController;
  TabController? tagsTabController;
  late final TabController videoTypeTabController;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithScrollOffset initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndex3Key;
    return _DataKeeper(
      sortMark: getSortMarkByIndex(key.index1),
      tagsTitle: getTagsTitleByIndex(key.index2),
      videoType: getVideoTypeByIndex(key.index3),
    );
  }

  void onTapLayout() => layout.value =
      layout.value == VideoLayout.big ? VideoLayout.small : VideoLayout.big;

  void _onMarkTabIndexChange(int index1) {
    final index2 = tagsTabController!.index;
    final index3 = videoTypeTabController.index;
    onTabChange(BaseRefreshTabIndex3Key(index1, index2, index3));
  }

  void _onTagsTabIndexChange(int index2) {
    final index1 = markTabController.index;
    final index3 = videoTypeTabController.index;
    onTabChange(BaseRefreshTabIndex3Key(index1, index2, index3));
  }

  void _onVideoTabIndexChange(int index3) {
    final index1 = markTabController.index;
    final index2 = tagsTabController!.index;
    onTabChange(BaseRefreshTabIndex3Key(index1, index2, index3));
  }

  Future<void> fetchTags() async {
    change(null, status: RxStatus.loading());
    final r = await Api.fetchTagsList();
    if (r == null) {
      change(null, status: RxStatus.error());
    } else {
      tagTabs.add(TagsModel.all());
      tagTabs.addAll(r);

      tagsTabController?.dispose();
      tagsTabController = TabController(length: tagTabs.length, vsync: this)
        ..addFastListener((i) => _onTagsTabIndexChange(i));
      change(null, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    markTabController = TabController(length: markTabs.length, vsync: this)
      ..addFastListener((i) => _onMarkTabIndexChange(i));
    videoTypeTabController =
        TabController(length: videoTypeTabs.length, vsync: this)
          ..addFastListener((i) => _onVideoTabIndexChange(i));
    currentTabKey = BaseRefreshTabIndex3Key(0, 0, 0);
    fetchTags();
    super.onInit();
  }

  @override
  void onClose() {
    markTabController.dispose();
    videoTypeTabController.dispose();
    tagsTabController?.dispose();
  }
}
