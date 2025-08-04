import 'package:android_dynamic_icon/android_dynamic_icon.dart';
import 'package:get/get.dart';

class AndroidDynamicIconUtils {
  ///单例模式
  static final AndroidDynamicIconUtils _instance =
      AndroidDynamicIconUtils._internal();

  factory AndroidDynamicIconUtils() {
    return _instance;
  }

  AndroidDynamicIconUtils._internal();

  final androidDynamicIconPlugin = AndroidDynamicIcon();

  List<String> _classNames = [];

  ///初始化动态图标
  ///因为第一次更换图标会生成两个图标，所以需要在初始化时添加一个空的图标类名
  Future<void> initialize(List<String> classNames) async {
    if (GetPlatform.isAndroid) {
      _classNames = classNames;
      _classNames.add('IconEmpty');
      await AndroidDynamicIcon.initialize(classNames: _classNames);
    }
  }

  ///更改动态图标
  /// [className] 是要更改为的图标类名
  /// 因为 Android 动态图标需要在第一次更改时生成两个图标，所以需要先更改为一个空的图标类名，然后再更改为目标图标类名
  /// 后面再处理
  Future<void> changeIcon(String className) async {
    if (GetPlatform.isAndroid) {
      // await androidDynamicIconPlugin.changeIcon(classNames: [_classNames.last, '']);
      /// 等待一段时间，确保第一个图标生成完成
      // await Future.delayed(const Duration(seconds: 5));
      await androidDynamicIconPlugin.changeIcon(classNames: [className, '']);
    }
  }
}
