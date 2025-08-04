/*
 * @Author: wangdazhuang
 * @Date: 2024-09-12 10:13:12
 * @LastEditTime: 2025-06-27 20:49:44
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/main/controllers/main_controller.dart
 */
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:baby_app/services/app_service.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:http_service/http_service.dart';
import 'package:universal_html/html.dart';

import '../../../components/announcement/announcement.dart';
import '../../../model/mine/service_model.dart';

class MainController extends GetxController {
  final userService = Get.find<UserService>();
  static const homeIndex = 0;
  static const community = 1;
  static const forbidden = 2;
  static const discover = 3;
  static const mine = 4;

  final currentIndex = 0.obs;

  void changeMainTabIndex(int i) {
    if (i != currentIndex.value) {
      currentIndex.value = i;

      if (i == forbidden || i == mine) {
        userService.updateAll();
      }
    }
  }

  ///存储在线客服地址
  void _fetchOnLineApi() async {
    try {
      ServiceModel? resp = await httpInstance.get(
        url: 'news/customer/sign',
        complete: ServiceModel.fromJson,
      );
      if (resp == null) return;
      Get.find<StorageService>().setOneLineApI(resp.signUrl ?? '');
    } catch (_) {}
  }

  ///更新用户信息
  void _updateAll() async {
    Get.find<UserService>().updateAll();
  }

  @override
  void onInit() {
    ///写代码时候老是弹 节约时间就先debugmode屏蔽
    // if (!kDebugMode)
    showAllEntranceAds();
    _fetchOnLineApi();
    _updateAll();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
