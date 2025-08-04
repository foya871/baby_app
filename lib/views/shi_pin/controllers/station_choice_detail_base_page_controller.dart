import '../../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../common/base/shi_pin_sort_layout_controller.dart';
import '../common/base/shi_pin_sort_tab_bar.dart';

const _pageSize = 60;
bool _userObs = true;

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<VideoBaseModel> {
  Future<List<VideoBaseModel>?> Function(int page, int pageSize) api;
  _DataKeeper({required this.api});

  @override
  bool get useObs => _userObs;

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
          {required bool isRefresh}) =>
      api(page, _pageSize);
}

abstract class StationChoiceDetailBasePageController
    extends BaseRefreshDefaultTabController with ShiPinSortLayoutController {
  // 抽象函数
  String get title;
  String get info;
  String get coverImg;
  bool get isVerticalLayout;
  Future<List<VideoBaseModel>?> Function(int page, int pageSize) dataFetcherApi(
      VideoSortType sortType);

  @override
  bool get useObs => _userObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    final sortType = ShiPinSortTabBar.getSortType(key.index);
    return _DataKeeper(api: dataFetcherApi(sortType));
  }
}
