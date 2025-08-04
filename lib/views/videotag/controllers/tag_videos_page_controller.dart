import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../http/api/api.dart';
import '../../../model/video_base_model.dart';
import '../../../utils/utils.dart';

const _useObs = true;
const _pageSize = 60;

const _sortTypeHot = 1;
const _sortTypeLatest = 2;
const _sortTypeMostPlay = 3;

const _typeShort = 2; // 短视频

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<VideoBaseModel> {
  final String tagsTitle;
  final int type;
  final int sortType;

  _DataKeeper({
    required this.tagsTitle,
    required this.type,
    required this.sortType,
  });

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
          {required bool isRefresh}) =>
      Api.fetchVideosByTag(
        tagTitle: tagsTitle,
        type: type,
        sortType: sortType,
        page: page,
        pageSize: _pageSize,
      );

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}

class TagVideosPageController extends BaseRefreshDefaultTabController {
  static final tabs = ['热门推荐', '最新上架', '最多观看'];
  static const tabIndexHot = 0;
  static const tabIndexLatest = 1;
  static const tabIndexMostPlay = 2;

  int _getSortTypeByTabIndex(int tabIndex) => switch (tabIndex) {
        tabIndexHot => _sortTypeHot,
        tabIndexLatest => _sortTypeLatest,
        tabIndexMostPlay => _sortTypeMostPlay,
        _ => _sortTypeHot,
      };

  late final String tagsTitle;
  late final int type;

  bool get isVerticalLayout => type == _typeShort;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      tagsTitle: tagsTitle,
      type: type,
      sortType: _getSortTypeByTabIndex(key.index),
    );
  }

  @override
  void onInit() {
    super.onInit();
    tagsTitle = Utils.asType<String>(Get.arguments?['tagsTitle'])!;
    type = Utils.asType<int>(Get.arguments?['type'])!;
  }
}
