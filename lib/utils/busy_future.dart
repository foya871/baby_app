import 'package:tuple/tuple.dart';

mixin BusyFuture {
  final _calling = <dynamic>{};

  Future<Tuple2<bool, T?>> busyCall<T>(
    dynamic key,
    Future<T> Function() task,
  ) async {
    if (_calling.contains(key)) {
      return Tuple2(false, null);
    }
    try {
      _calling.add(key);
      final result = await task();
      return Tuple2(true, result);
    } finally {
      // 这里不catch， 外部自行处理
      _calling.remove(key);
    }
  }
}
