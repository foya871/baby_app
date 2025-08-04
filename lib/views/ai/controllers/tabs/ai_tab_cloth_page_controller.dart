import 'package:get/get.dart';

import '../../../../components/image_picker/easy_image_picker.dart';
import '../../../../components/image_picker/easy_image_picker_file.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../http/service/api_code.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/enum.dart';
import '../../common/ai_bytes_image.dart';
import '../../common/popup/ai_cost_gold_confirm_dialog.dart';
import '../../common/popup/ai_no_image_tips_dialog.dart';

class AiTabClothPageController extends GetxController {
  // static final steps = <AiStep>[
  //   AiStep('选择照片'),
  //   AiStep('选择并上传'),
  //   AiStep('一键去衣'),
  // ];

  //
  final pickedImage = AiBytesImage.empty().obs;
  final step = AiPickImageStep.waitSelect.obs;
  // final stepController = AiStepperController();

  void onTapPicker(EasyImagePickerFile? file) async {
    if (file == null) return;
    final bytes = await file.bytes;
    if (bytes == null) return;
    pickedImage.value = AiBytesImage(bytes: bytes);
    step.value = AiPickImageStep.waitSubmit;
    // stepController.setActive(step.value);
  }

  void onTapUpload() async {
    final file = await EasyImagePicker.pickSingleImageGrant();
    onTapPicker(file);
  }

  void onTapClear() {
    pickedImage.value = AiBytesImage.empty();
    step.value = AiPickImageStep.waitSelect;
    // stepController.setActive(step.value);
  }

  void onTapMake() async {
    if (pickedImage.value.isEmpty) {
      AiNoImageTipsDialog().show();
      return;
    }
    final userService = Get.find<UserService>();
    var costType = userService.checkAiCost(
      costAiNum: Consts.aiClothCostCount,
      costGold: Consts.aiClothCostGold,
    );
    // costType = AiCostType.gold;
    if (costType == AiCostType.fail) {
      ApiCode.defaultGoldLackHandler();
    } else if (costType == AiCostType.gold) {
      AiCostGoldConfirmDialog.cloth(
        Consts.aiClothCostGold,
        onConfirm: _onMakeConfirm,
      ).show();
    } else {
      _onMakeConfirm();
    }
  }

  void _onMakeConfirm() async {
    final future = Api.createAiClothOffBoxOrder(pickedImage.value.bytes);
    final resp = await FutureLoadingDialog(future, tips: '上传中..').showUnsafe();
    ApiCode.handle(
      resp,
      successToast: '提交成功',
      onSuccess: () {
        step.value = AiPickImageStep.submitted;
        // stepController.setActive(step.value);
      },
    );
  }
}
