import 'dart:math';

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';
import 'ad_enum.dart';
import 'ad_info_model.dart';

class AdUtils {
  //单例模式
  static final AdUtils _instance = AdUtils._internal();

  factory AdUtils() {
    return _instance;
  }

  AdUtils._internal();

  List<AdInfoModel> get ads => Get.find<StorageService>().ads ?? [];

  /// 根据类型获取权重
  AdInfoModel? getAdInfo(AdApiType type) {
    if (type == AdApiType.INVALID) return null;
    if (ads.isEmpty) return null;
    var result = ads.where((e) => e.adPlace == type.name).toList();
    if (result.isEmpty) return null;
    result.sort(
        (a, b) => (a.importanceNum ?? 0).compareTo((b.importanceNum ?? 0)));
    final weights = result.map((e) => e.importanceNum ?? 0).toList();
    final sum = weights.reduce((a, b) => a + b);
    final random = Random().nextInt(sum);

    var index = 0;
    weights.forEachIndexed((index, e) {
      final arr = weights.sublist(0, index + 1);
      final temSum = arr.reduce((a, b) => a + b);
      result[index].weightSum = temSum;
    });
    //安全值判断处理
    index = result.indexWhere((e) => (e.weightSum ?? 0) >= random);
    if (index == -1) index = 0;
    return result[index];
  }

  ///根据顺序加载广告
  List<AdInfoModel> getAdLoadInOrder(AdApiType type) {
    if (ads.isEmpty) return [];
    final items = ads.where((e) => e.adPlace == type.name).toList();
    return items;
  }

  ///获取广告插入的间隔数
  int getInsertInterval(AdApiType type) {
    if (ads.isEmpty) return 5;
    final item = ads.firstWhereOrNull((e) => e.adPlace == type.name);
    if (item == null) return 5;
    final num = item.insertIntervalsNum ?? 0;
    if (num == 0) return 5;
    return num;
  }

  int interval(AdApiType place) {
    final info = getAdLoadInOrder(place);
    if (info.isEmpty) return 0;
    return getInsertInterval(place);
  }

  int withAdLength(int modelsLength, {required int interval}) {
    if (interval == 0) return modelsLength;
    return modelsLength + modelsLength ~/ interval;
  }
}
