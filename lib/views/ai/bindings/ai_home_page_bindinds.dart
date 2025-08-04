import 'package:get/get.dart';

import '../controllers/ai_home_page_controller.dart';
import '../controllers/tabs/ai_tab_cloth_page_controller.dart';
import '../controllers/tabs/ai_tab_face_custom_page_controller.dart';
import '../controllers/tabs/ai_tab_face_image_page_controller.dart';
import '../controllers/tabs/ai_tab_face_video_page_controller.dart';

class AiHomePageBindinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiHomePageController());
    Get.lazyPut(() => AiTabClothPageController());
    Get.lazyPut(() => AiTabFaceImagePageController());
    Get.lazyPut(() => AiTabFaceVideoPageController());
    Get.lazyPut(() => AiTabFaceCustomPageController());
  }
}
