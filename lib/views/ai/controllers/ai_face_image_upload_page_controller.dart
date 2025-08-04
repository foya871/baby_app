import 'package:get/get.dart';

import '../../../components/image_picker/easy_image_picker_file.dart';
import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_code.dart';
import '../../../model/ai/ai_models.dart';
import '../../../routes/routes.dart';
import '../../../services/user_service.dart';
import '../../../utils/consts.dart';
import '../../../utils/enum.dart';
import '../../../utils/extension.dart';
import '../../../utils/utils.dart';
import '../common/ai_bytes_image.dart';
import '../common/popup/ai_cost_gold_confirm_dialog.dart';
import '../common/popup/ai_no_image_tips_dialog.dart';
import '../common/popup/ai_wxts_image_dialog.dart';

class AiFaceImageUploadPageController extends GetxController {
  late final AiStencilModel stencil;
  final pickedImage = AiBytesImage.empty().obs;
  final step = AiPickImageStep.waitSelect.obs;

  void onTapPick(EasyImagePickerFile? file) async {
    if (file == null) return;
    final bytes = await file.bytes;
    if (bytes == null) return;
    pickedImage.value = AiBytesImage(bytes: bytes);
    step.value = AiPickImageStep.waitSubmit;
  }

  void onTapClear() {
    pickedImage.value = AiBytesImage.empty();
    step.value = AiPickImageStep.waitSelect;
  }

  void onTapMake() {
    if (pickedImage.value.isEmpty) {
      AiNoImageTipsDialog().show();
      return;
    }
    AiWxtsImageDialog(
      onConfirm: () {
        final userService = Get.find<UserService>();
        final costType = userService.checkAiCost(
          costAiNum: Consts.aiFaceImageCostCount,
          costGold: stencil.amount,
        );
        if (costType == AiCostType.fail) {
          ApiCode.defaultGoldLackHandler();
        } else if (costType == AiCostType.gold) {
          AiCostGoldConfirmDialog.faceImage(
            stencil.amount,
            onConfirm: () => _onMakeConfirm(),
          ).show();
        } else {
          _onMakeConfirm();
        }
      },
    ).show();
  }

  void _onMakeConfirm() async {
    final future = Api.createAiFaceImageOrder(
      stencil.stencilId,
      pickedImage.value.bytes,
    );
    final resp = await FutureLoadingDialog(future, tips: '上传中..').showUnsafe();
    ApiCode.handle(resp, successToast: '提交成功', onSuccess: () {
      step.value = AiPickImageStep.submitted;
      Get.untilNamed(Routes.aiHome);
    });
  }

  @override
  void onInit() {
    stencil = Utils.asType<AiStencilModel>(Get.arguments)!;
    super.onInit();
  }
}
