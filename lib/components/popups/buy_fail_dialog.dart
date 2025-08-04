import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../popup/dialog/base_confirm_dialog.dart';

class BuyFailDialog extends BaseConfirmDialog {
  BuyFailDialog()
      : super(
          titleText: '支付失败',
          descText: '金币余额不足',
          cancelText: '取消',
          confirmText: '立即充值',
          onConfirm: () => Get.toWallet(),
        );
}
