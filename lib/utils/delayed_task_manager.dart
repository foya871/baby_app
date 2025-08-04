import 'dart:async';

/// 延迟任务管理类
/// 主要处理场景：中间需要中断重新计时的情况
class DelayedTaskManager {
  DelayedTaskManager._internal();

  static final DelayedTaskManager instance = DelayedTaskManager._internal();

  final Map<String, Timer> _tasks = {};

  /// 启动一个延迟任务（相同 key 会重启）
  void start({
    required String key,
    required Duration delay,
    required void Function() action,
  }) {
    cancel(key); // 重启前先取消
    _tasks[key] = Timer(delay, () {
      _tasks.remove(key);
      action();
    });
  }

  /// 取消某个任务
  void cancel(String key) {
    _tasks[key]?.cancel();
    _tasks.remove(key);
  }

  /// 取消所有任务
  void cancelAll() {
    for (final timer in _tasks.values) {
      timer.cancel();
    }
    _tasks.clear();
  }

  /// 判断某个任务是否正在等待
  bool isScheduled(String key) {
    return _tasks[key]?.isActive ?? false;
  }
}
