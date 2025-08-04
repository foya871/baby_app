import 'package:get/get.dart';

import '../../../../components/image_picker/easy_image_picker_file.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../http/service/api_code.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/logger.dart';
import '../../common/ai_bytes_image.dart';
import '../../common/popup/ai_cost_gold_confirm_dialog.dart';
import '../../common/popup/ai_no_image_tips_dialog.dart';
import '../../common/popup/ai_wxts_image_dialog.dart';

class AiTabFaceCustomPageController extends GetxController {
  //
  final targetImage = AiBytesImage.empty().obs;
  final stencilImage = AiBytesImage.empty().obs;
  final targetStep = AiPickImageStep.waitSelect.obs;
  final stencilStep = AiPickImageStep.waitSelect.obs;

  Future<void> onTapTargetPicker(EasyImagePickerFile? file) async {
    if (file == null) return;
    final bytes = await file.bytes;
    if (bytes == null) return;
    targetImage.value = AiBytesImage(bytes: bytes);
    targetStep.value = AiPickImageStep.waitSubmit;
  }

  void onTapTargetClear() {
    targetImage.value = AiBytesImage.empty();
    targetStep.value = AiPickImageStep.waitSelect;
  }

  Future<void> onTapStencilPicker(EasyImagePickerFile? file) async {
    if (file == null) return;
    final bytes = await file.bytes;
    if (bytes == null) return;
    stencilImage.value = AiBytesImage(bytes: bytes);
    stencilStep.value = AiPickImageStep.waitSubmit;
  }

  void onTapStencilClear() {
    stencilImage.value = AiBytesImage.empty();
    stencilStep.value = AiPickImageStep.waitSelect;
  }

  void onTapMake() async {
    if (targetImage.value.isEmpty) {
      AiNoImageTipsDialog().show();
      return;
    }
    if (stencilImage.value.isEmpty) {
      AiNoStencilImageTipsDialog().show();
      return;
    }

    AiWxtsImageDialog(
      onConfirm: () {
        final userService = Get.find<UserService>();
        final costType = userService.checkAiCost(
          costAiNum: Consts.aiFaceCustomCostCount,
          costGold: Consts.aiFaceCustomCostGold,
        );
        if (costType == AiCostType.fail) {
          ApiCode.defaultGoldLackHandler();
        } else if (costType == AiCostType.gold) {
          AiCostGoldConfirmDialog.faceCustom(
            Consts.aiFaceCustomCostGold,
            onConfirm: _onMakeConfirm,
          ).show();
        } else {
          _onMakeConfirm();
        }
      },
    ).show();
  }

  void _onMakeConfirm() async {
    // 上传模版
    final orderNo = await FutureLoadingDialog(
      Api.createAiFaceCustomStencil(stencilImage.value.bytes),
      tips: '正在上传模版',
    ).show();
    if (orderNo == null) {
      logger.d('ai change custom create stencil fail');
      return;
    }
    // 下单
    final resp = await FutureLoadingDialog(
      Api.createAiFaceCustomOrder(
        file: targetImage.value.bytes,
        orderNo: orderNo,
      ),
      tips: '正在创建订单',
    ).show();
    ApiCode.handle(
      resp,
      successToast: '提交成功',
      onSuccess: () {
        targetStep.value = AiPickImageStep.submitted;
        stencilStep.value = AiPickImageStep.submitted;
        // onTapStencilClear();
        // onTapTargetClear();
      },
    );
  }
}
