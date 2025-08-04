/*
 * @Author: wangdazhuang
 * @Date: 2024-10-22 19:29:40
 * @LastEditTime: 2024-11-02 09:25:33
 * @LastEditors: wangdazhuang
 * @Description:
 * @FilePath: /dou_yin_jie_mi_app/lib/src/components/save_screen/save_screen.dart
 */
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

// import 'package:screenshot/screenshotdart';

import '../easy_toast.dart';
import 'permission_request.dart';

class SaveScreen {
  static Future<void> captureAndSaveScreenshot(Uint8List capturedImage,
      {bool isBack = true}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/screeshoot_${DateTime.now().millisecondsSinceEpoch}.png');
      final buffer = file.openWrite();
      await buffer
          .addStream(Stream.fromIterable([Uint8List.fromList(capturedImage)]));
      final result = await ImageGallerySaverPlus.saveFile(file.path);
      EasyToast.show(result["isSuccess"] ? '保存成功' : '保存失败');
      buffer.flush();
      await buffer.close();
      if (isBack) {
        Get.back();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<bool> permissionCheckAndRequest(
      BuildContext context, Permission permission, String permissionTypeStr,
      {bool isRequiredPermission = false}) async {
    if (!await permission.status.isGranted) {
      if (!context.mounted) return false;

      await Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: ((context, animation, secondaryAnimation) {
            return PermissionRequestPage(permission, permissionTypeStr,
                isRequiredPermission: isRequiredPermission);
          }),
        ),
      );
      return false;
    }
    return true;
  }

  static Future<void> onCaptureClick(
      BuildContext context, ScreenshotController screenshotController,
      {bool isBack = true}) async {
    if (kIsWeb) {
      EasyToast.show('请自行用手机截屏保存分享哦～');
      return;
    }

    if (!context.mounted) return;
    Permission p = Permission.photosAddOnly;
    if (GetPlatform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;
      p = sdkInt < 33 ? Permission.storage : Permission.photos;
    }
    // bool result = await SaveScreen.permissionCheckAndRequest(context, p, "存储");
    // if (result) {
    screenshotController
        .capture(delay: const Duration(milliseconds: 50))
        .then((capturedImage) async {
      if (capturedImage != null) {
        await SaveScreen.captureAndSaveScreenshot(capturedImage,
            isBack: isBack);
      }
    });
    // } else {
    //   EasyToast.show('如已授权请重新点击保存，否则请授权');
    // }
  }
}
