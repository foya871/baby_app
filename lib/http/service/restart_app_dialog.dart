/*
 * @Author: wangdazhuang
 * @Date: 2025-03-07 14:57:19
 * @LastEditTime: 2025-07-08 15:20:51
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/http/service/restart_app_dialog.dart
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:restart_app/restart_app.dart';
import 'package:universal_html/html.dart';

import '../../routes/routes.dart';
import '../../services/storage_service.dart';
import 'special_code_pop.dart';

abstract class RestartAppDialog {
  static void _dismiss() => SmartDialog.dismiss();

  /// 重启app
  static Future<void> _restartApp() async {
    final localStore = Get.find<StorageService>();
    await localStore.deleteToken();
    if (kIsWeb) {
      final origin = window.location.origin;
      window.location.replace(origin!);
    } else {
      Restart.restartApp();
    }
    _dismiss();
  }

  ///弹特殊状态码
  static void show({String? msg, String? url, int? code}) {
    final title = code != null ? ApiConst.spMaps[code] : msg ?? '';
    final desc = url ?? "请点击确定重新初始化app";
    SmartDialog.show(
      debounce: true,
      clickMaskDismiss: false,
      builder: (context) => SpecialCodePop(
        title: title,
        desc: desc,
        tap: () async {
          if (code != null) {
            ///特殊状态码
            if (code == ApiSpCodeEnum.reLogin) {
              ///302
              _dismiss();

              ///重新登录
              final routes = Get.routeTree.routes;
              if (routes.isNotEmpty) {
                Get.offNamed(Routes.mineLoginRegister);
              } else {
                Get.toNamed(Routes.mineLoginRegister);
              }
            } else {
              _restartApp();
            }
          } else {
            ///进入逻辑那里
            _restartApp();
          }
        },
      ),
      alignment: Alignment.center,
    );
  }
}
