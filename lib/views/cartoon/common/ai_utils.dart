import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/popup/dialog/future_loading_dialog.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/http/service/api_code.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:tuple/tuple.dart';
import 'package:baby_app/services/user_service.dart';

import 'ai_cost_gold_confirm_dialog.dart';
import 'ai_enum.dart';

class AiUtils {
  AiUtils._();

  ///开始制作换脸
  ///[isVideo] 是否是视频
  ///[costGold] 消耗的金币
  ///[imageBytes] 图片的字节流
  static void makeChangeFace({
    required AiType aiType,
    required String stencilId,
    required double costGold,
    required Uint8List imageBytes,
    File? file,
  }) {
    final userService = Get.find<UserService>();
    final Tuple3<int, String, int> data = _getAiData(aiType);
    //获取消耗的类型
    AiCostType costType = _checkAiType(
      freeAiNum: data.item1,
      costGold: costGold,
      userGold: userService.assets.gold ?? 0,
    );
    if (costType == AiCostType.fail) {
      showAlertDialog(
        Get.context!,
        title: "金币余额不足",
        message: "金币余额:${(userService.assets.gold ?? 0)}",
        rightText: "立即充值",
        onRightButton: () {},
      );
    } else if (costType == AiCostType.gold) {
      AiCostGoldConfirmDialog.show(
        costGold,
        data.item2,
        onConfirm: () =>
            _onMakeConfirm(data.item3, stencilId, imageBytes, file: file),
      ).show();
    } else {
      _onMakeConfirm(data.item3, stencilId, imageBytes, file: file);
    }
  }

  ///根据Ai类型获取相应的数据
  ///[aiType] Ai类型
  ///返回[Tuple]类型,可以后期扩展
  ///[item1] 免费的次数
  ///[item2] 标题
  ///[item3] 上传的类型 1-图片去衣 2-图片换脸 3-视频换脸
  static _getAiData(AiType aiType) {
    final userService = Get.find<UserService>();
  }

  ///选择消耗类型
  ///[freeAiNum] 免费的次数
  ///[costGold] 消耗的金币
  ///[userGold] 用户的金币
  static _checkAiType({
    required int freeAiNum,
    required double costGold,
    required double userGold,
  }) {
    if (freeAiNum > 0) {
      return AiCostType.num;
    }
    return userGold >= costGold ? AiCostType.gold : AiCostType.fail;
  }

  ///提交制作
  ///[type] 上传的类型 1-图片去衣 2-图片换脸 3-视频换脸 4-自定义换脸 5-视频去衣 6-GIF视频
  ///[stencilId] 模板id
  ///[bytes] 图片的字节流
  static void _onMakeConfirm(int type, String stencilId, Uint8List bytes,
      {File? file}) async {
    var resp;
    if (type == 5 || type == 6) {
      final milliseconds = DateTime.now().microsecondsSinceEpoch;
      final fileName = '$milliseconds.mp4';
      resp = await LoadingView.singleton.wrap(
          context: Get.context!,
          asyncFunction: () async {
            //先上报阿里云，获取预签名
          });
      showToast('提交成功');
    } else {}
  }
}
