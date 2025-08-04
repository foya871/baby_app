import 'package:flutter/foundation.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:http_service/http_service.dart';
import 'package:universal_html/html.dart' show window;

import '../../utils/ad_jump.dart';
import '../diolog/dialog.dart';
import 'pay_enum.dart';

class PayUtils {
  PayUtils._();

  /// 开始支付
  /// [amount] 支付金额
  /// [payId] 支付ID  VIP: vipId 金币: GoldId
  /// [purType] 购买类型
  /// [payType] 支付方式
  /// [payNumber] 购买的数量，默认 1
  /// [source] 来源类型
  static startPay({
    required double amount,
    required int payId,
    required PurTypeEnum purType,
    required PayTypeEnum payType,
    int purchaseQuantity = 1,
    SourceTypeEnum source = SourceTypeEnum.platformSelf,
    required double balance,
    bool isAddDeviceId = true,
    Function()? onSuccess,
  }) async {
    if (payType == PayTypeEnum.balance && balance < amount) {
      showToast("余额不足");
      return;
    }

    Map<String, dynamic> request = {
      'money': amount,
      'targetId': payId,
      'purType': purType.type,
      'rechType': payType.type,
      'nums': purchaseQuantity,
      'source': source.type,
    };
    if (isAddDeviceId) {
      request['deviceId'] = '';
    }
    var newWindow;

    if (kIsWeb && payType != PayTypeEnum.balance) {
      newWindow = window.open('', '_blank');
    }

    try {
      final response = await httpInstance.post(
        url: 'rech/sumbit',
        body: request,
      );

      String url = response['url'] ?? "";
      if (payType == PayTypeEnum.balance) {
        onSuccess?.call();
      }

      if (url.isNotEmpty) {
        if (kIsWeb) {
          newWindow.location.href = url;
        } else {
          jumpExternalURL(url);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
