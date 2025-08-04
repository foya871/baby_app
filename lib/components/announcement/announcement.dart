/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-28 10:02:57
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-05 13:43:18
 * @FilePath: /baby_app/lib/components/announcement/announcement.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:ui';

import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/components/announcement/version_update_box.dart';
import 'package:baby_app/model/announcement/announcement.dart';
import 'package:baby_app/model/announcement/app_update.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';

import '../../http/api/api.dart';
import '../../utils/logger.dart';
import 'notice_box.dart';
import 'open_screen_ads.dart';
import 'vertical_group_ads.dart';

Future<AppUpdateModel?> checkVersion() async {
  if (!kIsWeb) {
    try {
      final updates = await httpInstance.get<AppUpdateModel>(
          url: 'sys/version/update', complete: AppUpdateModel.fromJson);
      if (updates is AppUpdateModel && updates.hasNewVersion == true) {
        return updates;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  return null;
}

///作为安卓更新用的
Future<String?> fetchLandMarkURL() async {
  try {
    final result = await Api.getShareLink();
    if (result.isNotEmpty) {
      return result.first.url ?? '';
    }
    return "";
  } catch (e) {
    logger.d('$e');
    return null;
  }
}

void showAllEntranceAds(
    {bool? justBullet = false, VoidCallback? dismissAction}) async {
  ValueNotifier<int> acitveIdx = ValueNotifier(0);
  List<Widget> _toastList = [];

  ///下一个或者直接消失
  // ignore: no_leading_underscores_for_local_identifiers
  void _dismissOrNextAction() {
    if (acitveIdx.value == _toastList.length - 1) {
      SmartDialog.dismiss();
      if (justBullet == true) {
        dismissAction?.call();
      }
    } else {
      acitveIdx.value += 1;
    }
  }

  AppUpdateModel? versionModel;
  String? androidApkURL;
  if (!kIsWeb && justBullet == false) {
    androidApkURL = await fetchLandMarkURL();
  }

  ///系统更新
  if (!kIsWeb && justBullet == false) {
    versionModel = await checkVersion();
    logger.d('update:${versionModel != null}');
    if (versionModel != null && versionModel.hasNewVersion == true) {
      _toastList.add(VersionUpdateBox(
        model: versionModel,
        androidApkURL: androidApkURL,
        dismiss: _dismissOrNextAction,
      ));
    }
  }

  ///公告
  if (justBullet == false) {
    final ann = await httpInstance.get<AnnouncementModel>(
        url: 'sys/ann', complete: AnnouncementModel.fromJson);
    if (ann != null && ann is AnnouncementModel) {
      _toastList.add(NoticeBox(
        model: ann,
        dismiss: _dismissOrNextAction,
      ));
    }
  }

  ///九宫格广告
  if (justBullet == false) {
    final models = AdUtils().getAdLoadInOrder(AdApiType.INDEX_POP_ICON);
    if (models.isNotEmpty) {
      _toastList.add(OpenScreenAds(dismiss: _dismissOrNextAction));
    }
  }

  // 三个一组
  final models = AdUtils().getAdLoadInOrder(AdApiType.START_POP_UP);
  if (models.isNotEmpty) {
    final items = models.slices(3);
    if (items.isNotEmpty) {
      for (List<AdInfoModel> arr in items) {
        _toastList.add(VerticalGroupAds(
          models: arr,
          dismiss: _dismissOrNextAction,
        ));
      }
    }
  }

  showAllAds({
    bool clickMaskDismiss = false,
    double width = double.infinity,
    double height = double.infinity,
  }) async {
    final filter = ImageFilter.blur(sigmaX: 10, sigmaY: 10.0);
    SmartDialog.show(
        maskColor: const Color.fromRGBO(0, 0, 0, 0.5),
        builder: (_) {
          return BackdropFilter(
              filter: filter,
              child: ValueListenableBuilder(
                  valueListenable: acitveIdx,
                  builder: (context, value, child) {
                    return _toastList[value];
                  }));
        },
        clickMaskDismiss: clickMaskDismiss,
        onMask: () {
          if ((GetPlatform.isAndroid &&
              versionModel != null &&
              versionModel.hasNewVersion == true &&
              versionModel.isForceUpdate == true)) {
            return;
          }
          _dismissOrNextAction();
        });
  }

  if (_toastList.isEmpty) {
    if (justBullet == true) {
      dismissAction?.call();
    }
  } else {
    await showAllAds();
  }
}
