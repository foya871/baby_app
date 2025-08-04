import 'package:get/get.dart';

import '../controllers/ai_face_image_upload_page_controller.dart';

class AiFaceImageUploadPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiFaceImageUploadPageController());
  }
}
