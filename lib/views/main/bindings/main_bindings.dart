/*
 * @Author: wangdazhuang
 * @Date: 2025-01-15 18:39:28
 * @LastEditTime: 2025-06-27 20:27:24
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/main/bindings/main_bindings.dart
 */
import 'package:get/get.dart';
import 'package:baby_app/views/ai/bindings/ai_home_page_bindinds.dart';
import 'package:baby_app/views/community/community_page_controller.dart';
import 'package:baby_app/views/home/home_bindings.dart';

import '../../../services/app_service.dart';
import '../../mine/mine_page_controller.dart';
import '../../shi_pin/common/shi_pin_tab/shi_pin_tab_factory.dart';
import '../controllers/main_controller.dart';
import '../controllers/shi_pin_tab_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ShiPinTabController>(() => ShiPinTabController());
    Get.put(CommunityPageController());
    Get.lazyPut<MinePageController>(() => MinePageController());

    AiHomePageBindinds().dependencies();

    HomePageBinding().dependencies();

    final appService = Get.find<AppService>();
    for (final classify in appService.shiPinTabs) {
      ShiPinTabFactory.bind(classify);
    }
    if (appService.hasForbidden) {
      ShiPinTabFactory.bind(appService.forbiddenClassify!);
    }
  }
}
