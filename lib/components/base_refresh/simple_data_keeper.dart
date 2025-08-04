import 'package:get/get.dart';

import '../../utils/consts.dart';
import 'base_data_keeper.dart';
import 'base_refresh_page_counter.dart';

// 不绑定逻辑只有数据
class SimpleDataKeeper<E> with BaseDataKeeper<E>, BaseRefreshPageCounter {
  final bool obs;
  bool _noMore = false;
  SimpleDataKeeper(this.obs);
  @override
  bool get useObs => obs;

  bool get noMore => _noMore;
  bool get hasMore => !_noMore;

  void onRefreshSuccess(List<E> data, {required bool noMore}) {
    resetPage(Consts.pageFirst + 1); // 刷新成功后再设置
    setData(data);
    _noMore = noMore;
  }

  void onLoadSuccess(List<E> data, {required bool noMore}) {
    incPage();
    addData(data);
    _noMore = noMore;
  }
}

class SimpleMapDataKeeper<K, E> {
  final bool obs;
  final Map<K, SimpleDataKeeper<E>> _m;

  SimpleMapDataKeeper(this.obs)
      : _m = obs ? <K, SimpleDataKeeper<E>>{}.obs : <K, SimpleDataKeeper<E>>{};

  SimpleDataKeeper<E> _getOrInitKeeper(K k) {
    if (_m[k] == null) {
      _m[k] = SimpleDataKeeper(obs);
    }
    return _m[k]!;
  }

  int getPage(K k) => _getOrInitKeeper(k).page;
  List<E> getData(K k) => _getOrInitKeeper(k).data;
  bool dataInited(K k) => _getOrInitKeeper(k).dataInited;
  bool noMore(K k) => _getOrInitKeeper(k).noMore;
  void clearData(K k) => _m[k]?.clearData();

  void onRefreshSuccess(K k, List<E> data,
      {bool clearAll = true, required bool noMore}) {
    if (clearAll) {
      clearAllData();
    }
    _getOrInitKeeper(k).onRefreshSuccess(data, noMore: noMore);
  }

  void onLoadSuccess(K k, List<E> data, {required bool noMore}) =>
      _getOrInitKeeper(k).onLoadSuccess(data, noMore: noMore);

  void clearAllData() {
    _m.clear();
  }
}
