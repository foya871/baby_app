import 'package:get/get.dart';

import 'home_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    ///首页
    Get.put<HomePageController>(HomePageController(forbidden: false),
        tag: HomePageController.homeTag);

    ///禁区
    Get.put<HomePageController>(HomePageController(forbidden: true),
        tag: HomePageController.forbiddenTag);
  }
}
