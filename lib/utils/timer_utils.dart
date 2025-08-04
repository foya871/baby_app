import 'dart:async';

/// 一个用于管理和操作多个定时器的工具类。
/// 使用单例模式，确保整个应用中只有一个定时器管理器实例。
class TimerUtils {
  static TimerUtils? _instance; // 私有静态实例
  Map<String, Timer> _timers; // 存储所有定时器的映射

  // 私有构造函数
  TimerUtils._internal() : _timers = {};

  /// 获取单例实例的公共静态方法。
  static TimerUtils get instance {
    _instance ??= TimerUtils._internal();
    return _instance!;
  }

  /// 开始一个定时器，提供定时任务的标识符、间隔时间、总时间、计时器回调和完成回调。
  ///
  /// [taskId]：定时任务的唯一标识符。
  /// [intervalSeconds]：定时器触发的间隔时间（秒）。
  /// [totalSeconds]：定时器总运行时间（秒），如果为空则持续运行。
  /// [onTimerTick]：定时器每次触发时的回调函数。
  /// [onTimerFinish]：定时器完成或取消时的回调函数。
  /// [startImmediately]：用于控制是否立即启动定时器。
  /// [isCountdown]：如果为 true，则返回倒计时（剩余时间），否则返回已经过的时间。
  /// [resetIfExists]：如果定时器ID已存在，是否重置定时器（即停止当前定时器并重新创建）。
  Timer? startTimer({
    required String taskId,
    required int intervalSeconds,
    int? totalSeconds,
    Function(int elapsedSeconds)? onTimerTick,
    Function()? onTimerFinish,
    bool startImmediately = false,
    bool isCountdown = false,
    bool resetIfExists = false,
  }) {
    // 如果已存在同ID的定时器，并且不允许重置，则抛出异常
    if (_timers.containsKey(taskId)) {
      if (!resetIfExists) {
        throw TimerAlreadyExistsException(taskId);
      } else {
        // 如果需要重置，则先取消当前定时器
        cancelTimer(taskId);
      }
    }

    int elapsedSeconds = startImmediately ? 0 : 0;
    int remainingSeconds = totalSeconds ?? 0; // 用于倒计时的剩余时间

    // 如果startImmediately为true，立即执行一次定时器任务
    if (startImmediately) {
      if (isCountdown) {
        onTimerTick?.call(remainingSeconds); // 返回剩余时间
      } else {
        onTimerTick?.call(elapsedSeconds); // 返回已过时间
      }
    }

    // 创建并存储定时器
    _timers[taskId] =
        Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) {
      if (isCountdown) {
        // 倒计时模式，每次减少剩余时间
        remainingSeconds -= intervalSeconds;
        remainingSeconds =
            remainingSeconds < 0 ? 0 : remainingSeconds; // 确保不为负数
        onTimerTick?.call(remainingSeconds); // 返回剩余时间

        // 如果倒计时结束，则调用完成回调并取消定时器
        if (remainingSeconds <= 0) {
          cancelTimer(taskId); // 取消定时器
          onTimerFinish?.call(); // 调用完成回调
        }
      } else {
        // 正数模式，返回已过时间
        elapsedSeconds += intervalSeconds;
        onTimerTick?.call(elapsedSeconds); // 返回已过时间

        // 如果达到总时间，则取消定时器并调用完成回调
        if (totalSeconds != null && elapsedSeconds >= totalSeconds) {
          cancelTimer(taskId); // 取消定时器
          onTimerFinish?.call(); // 调用完成回调
        }
      }
    });

    return _timers[taskId]; // 返回创建的定时器
  }

  /// 取消特定ID的定时器。
  void cancelTimer(String taskId) {
    _timers[taskId]?.cancel(); // 取消定时器
    _timers.remove(taskId); // 从映射中移除定时器
  }

  /// 取消所有正在运行的定时器。
  void cancelAllTimers() {
    // 遍历并取消所有定时器
    for (var timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear(); // 清空定时器映射
  }
}

/// 自定义异常，用于处理定时器已存在的情况。
class TimerAlreadyExistsException implements Exception {
  final String taskId; // 定时任务的唯一标识符
  TimerAlreadyExistsException(this.taskId);

  @override
  String toString() => 'ID为 $taskId 的定时器已存在。';
}
