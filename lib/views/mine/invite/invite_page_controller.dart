import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/http/api/api.dart';

class InvitePageController extends GetxController {
  TextEditingController codeController = TextEditingController();

  submit() async {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      showToast("邀请码码不能为空！");
      return;
    }
    await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.submitInviteCode(inviteCode: code).then(
            (value) {
              if (value) {
                showToast("填写成功");
                Get.back();
              }
            },
          );
        });
  }
}
