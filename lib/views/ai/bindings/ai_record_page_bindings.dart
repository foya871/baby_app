import 'package:get/get.dart';

import '../controllers/ai_record_page_controller.dart';

class AiRecordPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AiRecordPageController());
  }
}
