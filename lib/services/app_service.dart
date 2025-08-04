/*
 * @Author: wangdazhuang
 * @Date: 2025-03-11 17:00:58
 * @LastEditTime: 2025-03-15 11:48:20
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/services/app_service.dart
 */
import 'dart:async';

import 'package:get/get.dart';

import '../http/api/api.dart';
import '../model/ai/ai_models.dart';
import '../model/classify/classify_models.dart';
import 'user_service.dart';

class AppService extends GetxService {
  // 暂时没有提供obs, 手动update, 有需要再改
  final shiPinTabs = <ClassifyModel>[];

  ClassifyModel? forbiddenClassify;

  bool get hasForbidden => forbiddenClassify != null;

  bool get isLiveEnable => aiEntrance.liveEnable;

  // 暂时没有提供obs, 手动update, 有需要再改
  AiEntranceConfigModel aiEntrance = AiEntranceConfigModel.empty();

  // <error>
  Completer<Object?> networkInitCompleter = Completer();

  // 短视频页面是否展示广告，全局生效，直至重启
  final _shortShowAd = true.obs;

  void hideShortAd() => _shortShowAd.value = false;

  bool get shortShowAd => !Get.find<UserService>().isVIP && _shortShowAd.value;

  Future<Object?> sendNetworkInitReq() {
    Future.wait([_updateClassifyTabs(), _updateAiEntrance()]).then((_) {
      if (shiPinTabs.isEmpty) {
        networkInitCompleter.complete(false);
      } else {
        networkInitCompleter.complete(true);
      }
    }).onError((err, stack) {
      networkInitCompleter.complete(false);
    });
    return networkInitCompleter.future;
  }

  Future<bool> _updateClassifyTabs() async {
    final shiPinClassify = await Api.fetchShiPinClasifyList();
    if (shiPinClassify != null) {
      shiPinTabs.assignAll(shiPinClassify.where((e) => !e.isForbidden));
      forbiddenClassify = shiPinClassify.firstWhereOrNull((e) => e.isForbidden);
    }
    return true;
  }

  Future<void> _updateAiEntrance() async {
    final res = await Api.fetchAiEntranceConfig();
    if (res != null) {
      aiEntrance = res;
    }
  }
}
