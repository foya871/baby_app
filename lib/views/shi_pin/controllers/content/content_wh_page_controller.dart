import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../model/content_model.dart';

const _pageSize = 20;
const _useObs = true;
const _orderTypeMostVideos = 1;
const _orderTypeMostFans = 2;
const _orderTypeNameFilter = 3;

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<ContentHotModel> {
  final BaseRefreshTabIndexKey tabKey;
  final String Function()? firstSpellGetter;
  _DataKeeper({required this.tabKey, this.firstSpellGetter});

  @override
  bool get useObs => _useObs;

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  Future<List<ContentHotModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    final orderType = ContentWhPageController.getOrderType(tabKey.index);
    return Api.fetchContentActressMore(
      page: page,
      pageSize: _pageSize,
      orderType: orderType,
      firstSpell: firstSpellGetter?.call(),
    );
  }
}

class ContentWhPageController extends BaseRefreshTabController {
  static const sortTypeTabs = [
    Tuple2('最多片量', _orderTypeMostVideos),
    Tuple2('最多粉丝', _orderTypeMostFans),
    Tuple2('姓名筛选', _orderTypeNameFilter),
  ];
  static const mostVideosIndex = 0;
  static const mostFansIndex = 1;
  static const nameFilterIndex = 2;
  static const defaultIndex = mostFansIndex;
  static int getOrderType(int index) => sortTypeTabs[index].item2;

  final selectedName = 'A'.obs;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      tabKey: key,
      firstSpellGetter:
          key.index == nameFilterIndex ? () => selectedName.value : null,
    );
  }

  void onTapName(String name) {
    selectedName.value = name;
    final future = onRefresh(BaseRefreshTabIndexKey(nameFilterIndex));
    FutureLoadingDialog(future).show();
  }
}
