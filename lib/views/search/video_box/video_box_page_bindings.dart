import 'package:get/get.dart';
import 'package:baby_app/views/search/video_box/video_box_page_controller.dart';

class VideoBoxPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoBoxPageController());
  }
}
