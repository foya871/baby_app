/*
 * @Author: wangdazhuang
 * @Date: 2024-09-07 09:07:51
 * @LastEditTime: 2024-09-07 09:09:24
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/components/image_viewer/image_viewer_bindings.dart
 */
import 'package:baby_app/components/image_viewer/image_viewer_controller.dart';
import 'package:get/get.dart';

class ImageViewerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageViewerController());
  }
}
