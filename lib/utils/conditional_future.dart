import 'dart:async';

import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

class ConditionalFuture<T> {
  final List<Future<T>> futures;
  final bool Function(T) condition;

  ConditionalFuture(this.futures, this.condition);

  Future<T?> any() async {
    return (await anyIndexed())?.item2;
  }

  Future<Tuple2<int, T>?> anyIndexed() {
    if (futures.isEmpty) return Future.value(null);
    final completer = Completer<Tuple2<int, T>?>();

    int completeCount = 0;
    futures.forEachIndexed((i, future) {
      future.then((result) {
        if (!completer.isCompleted && condition(result)) {
          completer.complete(Tuple2(i, result));
        }
      }).whenComplete(() {
        completeCount++;
        if (completeCount == futures.length) {
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        }
      });
    });

    return completer.future;
  }
}
