import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/http/api/api.dart';

import '../../../components/diolog/loading/loading_view.dart';

class ExchangePageController extends GetxController {
  TextEditingController codeController = TextEditingController();

  submit() async {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      showToast("兑换码不能为空！");
      return;
    }
    await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.redeemVip(code: code).then(
            (value) {
              if (value) {
                showToast("领取成功");
                Get.back();
              }
            },
          );
        });
  }
}
