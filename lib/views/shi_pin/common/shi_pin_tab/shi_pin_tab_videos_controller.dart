import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/base_refresh/base_refresh_share_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../model/tags_model.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../base/shi_pin_sort_layout_controller.dart';
import 'shi_pin_tab_base_controller.dart';

const _pageSize = 60;
const _useObs = true;

class _DataKeeper
    extends BaseRefreshDataKeeperWithScrollOffset<VideoBaseModel> {
  final int classifyId;
  final int sortType;
  final List<int>? Function() tagsIdGetter;

  _DataKeeper({
    required this.classifyId,
    required this.sortType,
    required this.tagsIdGetter,
  });

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.fetchVideoByCondition(
      page: page,
      pageSize: _pageSize,
      classifyId: classifyId,
      sortType: sortType,
      tagsId: tagsIdGetter(),
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}

class ShiPinTabVideosController extends ShiPinTabBaseShareTabContorller
    with ShiPinSortLayoutController, GetSingleTickerProviderStateMixin {
  ShiPinTabVideosController(super.classify) : super(enableJump: false);

  static const sortTabs = <Tuple2>[
    Tuple2<String, int>('最近更新', VideoSortTypeEnum.latest),
    Tuple2<String, int>('最多观看', VideoSortTypeEnum.mostPlayed),
    Tuple2<String, int>('最多喜欢', VideoSortTypeEnum.mostFav),
  ];

  static int getSortTypeByIndex(int index) => sortTabs[index].item2;

  final tags = <TagsModel>[].obs;
  final selectedTagIds = <int>[].obs;
  late final TabController tabContorller;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithScrollOffset initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      classifyId: classify.classifyId,
      sortType: getSortTypeByIndex(key.index),
      tagsIdGetter: () {
        final ids = selectedTagIds();
        if (ids.isEmpty) return null;
        return ids;
      },
    );
  }

  void onTapTag(int id) {
    if (selectedTagIds.contains(id)) {
      selectedTagIds.remove(id);
    } else {
      selectedTagIds.value = [id];
    }
    // 不刷新tag， 刷新视频
    FutureLoadingDialog(super.onRefresh()).show();
  }

  @override
  Future<IndicatorResult> onRefresh([bool checkNoMore = false]) async {
    selectedTagIds.clear();
    final tagsFuture = Api.fetchVideoHotTagsByClassify(classify.classifyId);
    final result = await super.onRefresh(checkNoMore);
    final tagsResult = await tagsFuture;
    tags.assignAll(tagsResult ?? []); // 容忍错误
    return result;
  }

  @override
  void onInit() {
    tabContorller = TabController(length: sortTabs.length, vsync: this)
      ..addFastListener((index) {
        onTabChange(BaseRefreshTabIndexKey(index));
      });
    currentTabKey = BaseRefreshTabIndexKey(tabContorller.index);
    super.onInit();
  }

  @override
  void onClose() {
    tabContorller.dispose();
    super.onClose();
  }
}
