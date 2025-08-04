import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'base_data_keeper.dart';
import 'base_refresh_page_counter.dart';

mixin BaseRefreshDataKeeper<E> on BaseDataKeeper<E>, BaseRefreshPageCounter {
  //
  Future<List<E>?> dataFetcher(int page, {required bool isRefresh});
  bool noMoreChecker(List<E> resp);
  // 数据发生变化，回调， 例如使用GetBuilder可以执行更新
  void onDataChange() {}

  @mustCallSuper
  Future<IndicatorResult> onRefresh([bool checkNoMore = false]) async {
    resetPage();
    final resp = await dataFetcher(page, isRefresh: true);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    setData(resp);
    onDataChange();
    if (checkNoMore && noMoreChecker(resp)) {
      return IndicatorResult.noMore;
    }
    incPage();
    return IndicatorResult.success;
  }

  @mustCallSuper
  Future<IndicatorResult> onLoad() async {
    final resp = await dataFetcher(page, isRefresh: false);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    addData(resp);
    if (resp.isNotEmpty) {
      onDataChange();
    }
    if (noMoreChecker(resp)) {
      return IndicatorResult.noMore;
    }
    incPage();
    return IndicatorResult.success;
  }

  @override
  void clearData([bool fromSet = true]) {
    super.clearData();
    if (!fromSet) {
      onDataChange();
    }
  }
}

abstract class BaseRefreshDataKeeperWithERController<E>
    with BaseDataKeeper<E>, BaseRefreshPageCounter, BaseRefreshDataKeeper {
  final refreshController = EasyRefreshController();
  ScrollController? _scrollController; // 大部分情况用不到, 延迟初始化

  ScrollController get scrollController =>
      _scrollController ??= ScrollController();

  void dispose() {
    refreshController.dispose();
    _scrollController?.dispose();
  }
}
