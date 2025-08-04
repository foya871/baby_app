import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:get/get.dart';

class ImageViewerController extends GetxController {
  List<CustomImageViewProvider> imgs = List<CustomImageViewProvider>.of([]);
  int i = 0;
  void initImgs() {
    List<String> items = Get.arguments;
    if (Get.parameters.isNotEmpty) {
      i = int.parse(Get.parameters["index"] ?? '0');
    }
    if (items.isEmpty) {
      return;
    }
    String domain = Get.find<StorageService>().imgDomain ?? '';
    if (items[0].startsWith("http")) {
      domain = '';
    }
    imgs = items.map((e) => CustomImageViewProvider(domain + e)).toList();
    update();
  }

  void setIndex(int v) {
    i = v;
    update();
  }
}
