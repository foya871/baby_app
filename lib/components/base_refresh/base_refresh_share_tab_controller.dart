import 'package:easy_refresh/easy_refresh.dart';
import 'package:baby_app/components/popup/dialog/future_loading_dialog.dart';
import 'package:get/get.dart';

import '../../utils/logger.dart';
import 'base_data_keeper.dart';
import 'base_refresh_data_keeper.dart';
import 'base_refresh_page_counter.dart';
import 'base_refresh_share_tab_widget.dart';
import 'base_refresh_single_controller.dart';
import 'base_refresh_tab_key.dart';

abstract class BaseRefreshDataKeeperWithScrollOffset<E>
    with BaseDataKeeper<E>, BaseRefreshPageCounter, BaseRefreshDataKeeper {
  double? scrollOffset;
}

///
/// 页面中 一个GetxController，多个tab，但是只通过一个refresh controller来控制
/// easy_refresh 在 nested_scroll_view 有问题, 才有这个写法
/// 用一个list模仿多个tab
/// 这里记录每个tab的滚动位置，然后改变tab后恢复滚动位置
///
/// 一个页面使用一个 see: [BaseRefreshShareTabWidget]
///

abstract class BaseRefreshShareTabController
    extends BaseRefreshSingleContronller {
  final bool enableJump;
  // 允许多种类型
  Map<BaseRefreshTabKey, BaseRefreshDataKeeperWithScrollOffset<dynamic>>?
      _datas;
  Map<BaseRefreshTabKey, BaseRefreshDataKeeperWithScrollOffset> get datas {
    if (useObs) {
      return _datas ??=
          <BaseRefreshTabKey, BaseRefreshDataKeeperWithScrollOffset<dynamic>>{}
              .obs;
    } else {
      return _datas ??=
          <BaseRefreshTabKey, BaseRefreshDataKeeperWithScrollOffset<dynamic>>{};
    }
  }

  BaseRefreshShareTabController({required this.enableJump});

  void clearAllDataKeeper() => datas.clear();

  // 这里指定为true，需要各项Keeper也需要指定为true
  bool get useObs;

  // 是否初始化了currentTabKey
  bool _currentTabKeyInited = false;
  RxBool? _currentTabKeyInitedRx;
  bool get currentTabKeyInited {
    if (useObs) {
      return (_currentTabKeyInitedRx ??= false.obs).value;
    } else {
      return _currentTabKeyInited;
    }
  }

  BaseRefreshTabKey? _currentTabKey;
  Rx<BaseRefreshTabKey>? _currentTabKeyRx;

  // 必须在调用前设置currentTabKey,否则报错
  K getCurrentTabKey<K extends BaseRefreshTabKey>() => currentTabKey as K;

  // 必须在调用前设置currentTabKey,否则报错
  BaseRefreshTabKey get currentTabKey {
    if (useObs) {
      assert(_currentTabKeyRx != null, 'currentTabKey not inited');
      return _currentTabKeyRx!.value;
    } else {
      assert(_currentTabKey != null, 'currentTabKey not inited');
      return _currentTabKey!;
    }
  }

  set currentTabKey(BaseRefreshTabKey tabKey) {
    if (useObs) {
      if (!currentTabKeyInited) {
        _currentTabKeyRx = tabKey.obs;
      } else {
        _currentTabKeyRx!.value = tabKey;
      }
      _currentTabKeyInitedRx!.value = true;
    } else {
      _currentTabKey = tabKey;
      _currentTabKeyInited = true;
    }
  }

  BaseRefreshDataKeeperWithScrollOffset initDataKeeper(
      BaseRefreshTabKey tabKey);

  BaseRefreshDataKeeperWithScrollOffset _getOrInit(BaseRefreshTabKey tabKey) =>
      datas.putIfAbsent(tabKey, () => initDataKeeper(tabKey));

  List<T> getData<T>(BaseRefreshTabKey tabKey) =>
      _getOrInit(tabKey).data as List<T>;
  List<T> getCurrentData<T>() => getData<T>(getCurrentTabKey());
  bool dataInited(BaseRefreshTabKey tabKey) => _getOrInit(tabKey).dataInited;
  bool get currentDataInited => _getOrInit(getCurrentTabKey()).dataInited;

  bool onTabChange(BaseRefreshTabKey toTabKey) {
    if (toTabKey == getCurrentTabKey()) return false;

    currentTabKey = toTabKey;

    final toDataKeeper = _getOrInit(toTabKey);
    if (!toDataKeeper.dataInited) {
      logger.d('change to tab${toTabKey.toKey()} call Refresh');
      // refreshController.callRefresh(); // 这里不使用callRefresh, 莫名其妙的问题
      FutureLoadingDialog(_doRefreshCurrentTab()).show();
    } else {
      if (enableJump) {
        final offset = toDataKeeper.scrollOffset;
        if (offset != null && offset >= 0) {
          scrollController.jumpTo(offset);
        }
      }
    }
    return true;
  }

  Future<IndicatorResult> _doRefreshCurrentTab() =>
      _getOrInit(getCurrentTabKey()).onRefresh();

  Future<IndicatorResult> onRefresh([bool checkNoMore = false]) =>
      _doRefreshCurrentTab();

  Future<IndicatorResult> onLoad() => _getOrInit(getCurrentTabKey()).onLoad();

  @override
  void onInit() {
    if (enableJump) {
      scrollController.addListener(() {
        if (!currentTabKeyInited) return;
        final dataKeeper = _getOrInit(getCurrentTabKey());
        dataKeeper.scrollOffset = scrollController.offset;
      });
    }
    super.onInit();
  }
}
