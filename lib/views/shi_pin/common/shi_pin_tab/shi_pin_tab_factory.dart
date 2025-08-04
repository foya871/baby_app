/*
 * @Author: wangdazhuang
 * @Date: 2025-02-17 15:01:29
 * @LastEditTime: 2025-02-22 09:48:38
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/shi_pin/common/shi_pin_tab/shi_pin_tab_factory.dart
 */
import 'package:get/get.dart';

import '../../../../model/classify/classify_models.dart';
import '../../../../utils/enum.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_videos_controller.dart';
import 'shi_pin_tab_videos_widget.dart';

abstract class ShiPinTabFactory {
  static ShiPinTabBaseWidget create(
      int classifyId, ShiPinClassifyType classifyType) {
    final tag = _tagBuilder(classifyId);
    if (classifyType == ShiPinClassifyTypeEnum.short) {
      return ShiPinTabVideosWidget(controllerTag: tag);
    }
    return ShiPinTabVideosWidget(controllerTag: tag);
  }

  static String _tagBuilder(int classifyId) => '$classifyId';

  static void bind(ClassifyModel classify) {
    final tag = _tagBuilder(classify.classifyId);
    if (classify.type == ShiPinClassifyTypeEnum.short) {
      ///短视频
      Get.lazyPut(
        () => ShiPinTabVideosController(classify),
        tag: tag,
      );
    } else {
      ///普通视频
      Get.lazyPut(
        () => ShiPinTabVideosController(classify),
        tag: tag,
      );
    }
  }
}
