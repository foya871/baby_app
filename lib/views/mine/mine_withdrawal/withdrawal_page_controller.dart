import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/mine/withdraw_config_model.dart';

import '../../../services/user_service.dart';

class WithdrawalPageController extends GetxController {
  final userService = Get.find<UserService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Rx<WithdrawConfigModel> withdrawConfig = WithdrawConfigModel().obs;

  var isAliPay = true.obs;

  @override
  void onReady() {
    super.onReady();
    getWithDrawConfig();
  }

  getWithDrawConfig() {
    Api.getWithdrawalConfig().then((response) {
      if (response != null) {
        withdrawConfig.value = response;
      }
    });
  }

  startWithdraw() {
    final amount = amountController.text.trim();
    if (amount.isEmpty) {
      showToast('请输入提现金额');
      return;
    }
    if (double.parse(amount) < (withdrawConfig.value.minQuota ?? 0)) {
      showToast('提现金额不能小于${withdrawConfig.value.minQuota ?? 0}');
      return;
    }
    if (double.parse(amount) > (withdrawConfig.value.maxQuota ?? 0)) {
      showToast('提现金额不能大于${withdrawConfig.value.maxQuota ?? 0}');
      return;
    }
    final name = nameController.text.trim();
    if (name.isEmpty) {
      showToast('请输入收款姓名');
      return;
    }

    final account = accountController.text.trim();
    if (account.isEmpty) {
      showToast('请输入提现账号');
      return;
    }
    LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          Api.applyWithdrawal(
            payType: isAliPay.value ? 1 : 3,
            purType: 2,
            money: amount,
            receiptName: name,
            accountNo: account,
          ).then((response) {
            if (response) {
              userService.updateAPIAssetsInfo();
              showToast("成功提交申请");
              Get.back();
            }
          });
        });
  }
}
