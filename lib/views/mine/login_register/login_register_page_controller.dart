import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:baby_app/utils/logger.dart';

import '../../../components/diolog/dialog.dart';
import '../../../components/diolog/loading/loading_view.dart';
import '../../../http/api/api.dart';
import '../../../model/user/user_info_model.dart';
import '../../../services/storage_service.dart';
import '../../../services/user_service.dart';

class LoginRegisterPageController extends GetxController {
  final userService = Get.find<UserService>();
  final storageService = Get.find<StorageService>();

  var isHaveAccount = false.obs;

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegExp accountRegExp = RegExp(r'^[a-zA-Z0-9_]*$');

  @override
  void onInit() {
    isHaveAccount.value = Get.arguments ?? false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  submit(bool isRegister) {
    logger.d("isRegister: $isRegister");
    final account = accountController.text.trim();
    if (account.isEmpty) {
      showToast("账号不能为空！");
      return;
    }
    if (account.length < 6) {
      showToast("请输入最少6位数账号/手机号！");
      return;
    }
    if (!accountRegExp.hasMatch(account)) {
      showToast("账号只能包含字母、数字、下划线");
      return;
    }
    final password = passwordController.text.trim();
    if (password.isEmpty) {
      showToast("密码不能为空！");
      return;
    }
    if (password.length < 6) {
      showToast("请输入密码 最少6位字符！");
      return;
    }
    userRegisterLogin(isRegister, account, password);
  }

  userRegisterLogin(bool isRegister, String account, String password) async {
    LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          UserInfo? response = await Api.userRegisterLogin(
              isRegister: isRegister, account: account, password: password);
          if (response != null) {
            final token = response.token ?? '';
            if (token.isNotEmpty) storageService.setToken(token);
            userService.updateAll();
            Get.back();
          }
        });
  }
}
