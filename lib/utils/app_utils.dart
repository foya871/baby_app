import 'package:flutter/services.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/generate/app_image_path.dart';

abstract class AppUtils {
  ///复制到粘贴板
  static Future<bool> copyToClipboard(String content) async {
    try {
      if (content.isNotEmpty) {
        await Clipboard.setData(ClipboardData(text: content));
        showToast("复制成功");
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  ///获取粘贴板的内容
  static Future<String> paste() async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  ///用户VIP身份：0：普通用户 2：体验卡 3：周卡  7:黄金卡 11:暗网卡  12:星耀卡
  static String getVipTypeToImagePath(int vipType) {
    String imagePath = '';
    if (vipType == 1) {
      imagePath = AppImagePath.mine_card_id_1;
    } else if (vipType == 3) {
      imagePath = AppImagePath.mine_card_id_3;
    } else if (vipType == 7) {
      imagePath = AppImagePath.mine_card_id_7;
    } else if (vipType == 11) {
      imagePath = AppImagePath.mine_card_id_11;
    } else if (vipType == 12) {
      imagePath = AppImagePath.mine_card_id_12;
    }
    return imagePath;
  }
}
