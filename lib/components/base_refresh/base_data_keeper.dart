import 'package:get/get.dart';

mixin BaseDataKeeper<E> {
  List<E>? _data;
  bool _dataInited = false;
  RxBool? _dataInitedRx;
  RxBool get _lateDataInitedRx => _dataInitedRx ??= false.obs;

  // 不会被set/clear重置
  bool get dataInited => useObs ? _lateDataInitedRx.value : _dataInited;

  bool get useObs => false;

  List<E> get data {
    if (useObs) {
      return _data ??= <E>[].obs;
    } else {
      return _data ??= <E>[];
    }
  }

  void setData(List<E>? d) {
    clearData(true);
    addData(d);
  }

  void addData(List<E>? d) {
    if (d != null && d.isNotEmpty) {
      data.addAll(d);
    }
    if (useObs) {
      _lateDataInitedRx.value = true;
    } else {
      _dataInited = true;
    }
  }

  void clearData([bool fromSet = false]) {
    _data?.clear();
  }
}
