import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_refresh_data_keeper.dart';
import 'base_refresh_simple_widget.dart';
import 'base_refresh_tab_key.dart';
import 'base_refresh_tab_widget.dart';

///
/// 页面中 一个GetxController, 多个tab，每个tab都有独立的一个refreshController
/// 使用多个 see: [BaseRefreshSimpleWidget]
///
/// 这里有两种方式
/// 一种是不指定currentTab,比如完全使用DefaultTabController的情况
/// 一种是有currentTab,比如使用自定义tabController或者IndexStack的情况
/// 这里对应两种类型
/// [BaseRefreshDefaultTabController]-->see [BaseRefreshTabWidget]
/// [BaseRefreshTabController] -> see [BaseRefreshTabWidget]
///

/// 不知道current，完全通过tabKey来处理
abstract class BaseRefreshDefaultTabController extends GetxController {
  final _datas = <BaseRefreshTabKey, BaseRefreshDataKeeperWithERController>{};
  RxMap<BaseRefreshTabKey, BaseRefreshDataKeeperWithERController>? _datasRx;
  RxMap<BaseRefreshTabKey, BaseRefreshDataKeeperWithERController>
      get _lateDatasRx => _datasRx ??=
          <BaseRefreshTabKey, BaseRefreshDataKeeperWithERController>{}.obs;

  bool get useObs => false;

  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey);

  BaseRefreshDataKeeperWithERController _getOrInit(BaseRefreshTabKey tabKey) =>
      (useObs ? _lateDatasRx : _datas)
          .putIfAbsent(tabKey, () => initDataKeeper(tabKey));

  List<T> getData<T>(BaseRefreshTabKey tabKey) =>
      _getOrInit(tabKey).data as List<T>;
  bool dataInited(BaseRefreshTabKey tabKey) => _getOrInit(tabKey).dataInited;
  EasyRefreshController getRefreshController(BaseRefreshTabKey tabKey) =>
      _getOrInit(tabKey).refreshController;
  ScrollController getScrollController(BaseRefreshTabKey tabKey) =>
      _getOrInit(tabKey).scrollController;

  Future<IndicatorResult> onRefresh<K extends BaseRefreshTabKey>(K tabKey,
          [bool checkNoMore = false]) =>
      _getOrInit(tabKey).onRefresh(checkNoMore);

  Future<IndicatorResult> onLoad<K extends BaseRefreshTabKey>(K tabKey) =>
      _getOrInit(tabKey).onLoad();

  @override
  void onClose() {
    _datas.forEach((_, v) => v.dispose());
    _datasRx?.forEach((_, v) => v.dispose());
    super.onClose();
  }
}

/// 手动切换currentTab
/// see: [BaseRefreshTabWidget]
abstract class BaseRefreshTabController
    extends BaseRefreshDefaultTabController {
  bool _currentTabKeyInited = false;
  bool get currentTabKeyInited => _currentTabKeyInited;
  late BaseRefreshTabKey _currentTabKey;
  late Rx<BaseRefreshTabKey> _currentTabKeyRx;

  BaseRefreshTabKey get currentTabKey =>
      useObs ? _currentTabKeyRx() : _currentTabKey;

  // 使用前必须先设置
  set currentTabKey(BaseRefreshTabKey tabKey) {
    if (!_currentTabKeyInited) {
      if (useObs) {
        _currentTabKeyRx = tabKey.obs;
      } else {
        _currentTabKeyRx.value = tabKey;
      }
    } else {
      _currentTabKey = tabKey;
    }
    if (!_currentTabKeyInited) {
      _currentTabKeyInited = true;
    }
  }

  List<T> getCurrentData<T>() => getData(currentTabKey);
  bool get currentDataInited => dataInited(currentTabKey);

  bool onTabChange(BaseRefreshTabKey toTabKey) {
    if (toTabKey == currentTabKey) return false;
    currentTabKey = toTabKey;
    return true;
  }
}
