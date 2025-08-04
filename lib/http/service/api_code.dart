import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import '../../components/easy_toast.dart';
import '../../services/user_service.dart';
import '../../components/popups/buy_fail_dialog.dart';
import 'package:flutter/material.dart';

typedef ApiCodeHandlers = Map<int, VoidCallback>;

abstract class ApiCode {
  ///
  static const int magicErr = -987654321;
  static const int goldLack = 1019; // 金币不足
  static const int aiMaintain = 1039; // AI 维护

  static Future<BaseRespModel<T>> warp<T>(Future future) async {
    try {
      final T resp = await future;

      assert(resp is! BaseRespModel, '<ApiCode> warp in warp.');

      return BaseRespModel.ok(data: resp);
    } catch (e) {
      return ApiErrorWrap.wrap(e);
    }
  }

  static void defaultGoldLackHandler() => BuyFailDialog().show();

  static final ApiCodeHandlers _defaultFailHandlers = {
    goldLack: defaultGoldLackHandler,
  };

  /// onFail 比 onFails 优先级更高
  /// onFails 比 defaultFails 优先级高
  /// onFail 没有code区分，
  /// onFails 区分code
  static void handle(
    BaseRespModel? resp, {
    String? successToast,
    String? failToast,
    VoidCallback? onSuccess,
    VoidCallback? onFail,
    ApiCodeHandlers? onFails, // 只处理失败
    bool tryDefaultFails = true, // 是否尝试defalut
    bool updateUserOnSuccess = true, // 这里都是一些操作金币的接口,默认设为true
  }) {
    if (resp == null) return;
    if (resp.success) {
      if (successToast != null && successToast.isNotEmpty) {
        EasyToast.show(successToast);
      }
    } else {
      if (failToast != null && failToast.isNotEmpty) {
        EasyToast.show(failToast);
      }
    }
    if (resp.success) {
      onSuccess?.call();
      if (updateUserOnSuccess) {
        Get.find<UserService>().updateAll();
      }
      return;
    }
    // onFail
    if (onFail != null) {
      onFail();
      return;
    }
    // onFails
    final handler = onFails?[resp.code];
    if (handler != null) {
      handler();
      return;
    }
    // default
    if (!tryDefaultFails) {
      return;
    }
    _defaultFailHandlers[resp.code]?.call();
  }
}
