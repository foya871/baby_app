import 'package:get/get.dart';

import '../controllers/tag_videos_page_controller.dart';

class TagVideosPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagVideosPageController());
  }
}
