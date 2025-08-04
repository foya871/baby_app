/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 17:25:14
 * @LastEditTime: 2024-11-08 14:10:55
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /51chigua_app/lib/common/components/popup/dialog/video_in_waiting_dialog.dart
 */
import 'package:get/get.dart';
import 'package:baby_app/routes/routes.dart';
import '../popup/dialog/base_confirm_dialog.dart';

class VideoInWaitingDialog extends BaseConfirmDialog {
  VideoInWaitingDialog()
      : super(
          titleText: '温馨提示',
          descText: '视频已在下载队列中.',
          cancelText: '取消',
          confirmText: '查看下载',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
          onConfirm: () {
            // Get.toNamed(Routes.mineDownload);
          },
        );
}
