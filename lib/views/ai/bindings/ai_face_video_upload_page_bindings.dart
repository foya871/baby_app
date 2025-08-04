import 'package:get/get.dart';

import '../controllers/ai_face_video_upload_page_controller.dart';

class AiFaceVideoUploadPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiFaceVideoUploadPageController());
  }
}
