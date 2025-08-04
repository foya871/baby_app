import 'package:get/get.dart';

import '../../controllers/content/content_wh_page_controller.dart';

class ContentWhPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentWhPageController());
  }
}
