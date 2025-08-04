import 'package:get/get.dart';

import '../../controllers/rank/shi_pin_rank_page_controller.dart';

class ShiPinRankPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShiPinRankPageController());
  }
}
