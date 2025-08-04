/*
 * @Author: wangdazhuang
 * @Date: 2024-08-23 10:41:49
 * @LastEditTime: 2025-07-05 13:33:30
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/utils/ad_jump.dart
 */
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:baby_app/utils/file_downloader.dart';
import 'package:baby_app/utils/logger.dart';
import 'package:baby_app/views/webview/webview_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as ddd;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_service/http_service.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:universal_html/html.dart' show window;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/diolog/loading/loading_view.dart';
import '../components/easy_toast.dart';
import '../env/environment_service.dart';

const urlPrefix = 'jh://jh/';

abstract class JumpProtocolEnum {
  //长视频 "jh://jh/video?videoId=123"
  static const video = 'video';

  //活动 "jh://jh/activity?url=https://www.baidu.com";
  static const activity = "activity";

  //会员  "jh://jh/rech";
  static const rech = 'rech';

  //钱包  "jh://jh/wall";
  static const wall = 'wall';

  //分享  "jh://jh/share";
  static const share = 'share';

  //加群  "jh://jh/group";
  static const group = 'group';

  //博主主页  "jh://jh/blogger?bloggerId=123";
  static const blogger = 'blogger';

  //AI"jh://jh/ai";
  static const ai = 'ai';
}

//点击上报
void _reportAd({required String adId}) => httpInstance.post(
      url: 'all/ad/click/report',
      body: {
        "id": adId,
      },
    );

// 跳转外部链接
void jumpExternalURL(
  String url, {
  String? adId,
}) async {
  if (adId != null) _reportAd(adId: adId);
  if (GetPlatform.isAndroid && url.contains(".apk")) {
    ///站内下载apk包
    var percentage = 0.0.obs;
    final res = await LoadingView.singleton.wrapWidget(
      context: Get.context!,
      background: Colors.black.withValues(alpha: 0.5),
      color: Colors.white,
      child: Obx(
        () => ddd.Text(
          '下载中:${percentage.value.toStringAsFixed(2)}%',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      asyncFunction: () async {
        final res = await _androidInnerAppDownloadApk(url, (p) {
          percentage.value = p;
        });
        return res;
      },
    );
    if (res == FileDownloaderResult.fail) {
      EasyToast.show("下载失败，请重试!");
      return;
    }

    if (res == FileDownloaderResult.success) {
      final filePath = await filedownloader.fileSavePathForNative(url);
      final insRes = await InstallPlugin.install(filePath);
      EasyToast.show(insRes['isSuccess'] == true
          ? '安装成功'
          : '安装失败:${insRes['errorMessage'] ?? ''}');
      return;
    }
    return;
  }
  Uri? path = Uri.tryParse(url);
  if (path == null) {
    logger.d('jumpExternalURL bad url');
    return;
  }

  if (kIsWeb) {
    _iosOpenURl(url);
    return;
  }
  try {
    if (!await canLaunchUrl(path)) {
      logger.d('jumpExternalURL can not launch url:$url');
      return;
    }

    if (!await launchUrl(path, mode: LaunchMode.externalApplication)) {
      logger.d('jumpExternalURL launch fail url:$url');
    }
  } catch (e) {
    logger.d('jumpExternalURL launch fail url:$url e:$e');
  }
}

_iosOpenURl(String url) async {
  var newWindow;
  newWindow = window.open(url, '_blank');
  Future.delayed(const Duration(milliseconds: 500), () {
    newWindow.location.href = url;
  });
}

//跳转内部
void jumpInternalAddress(String url) {
  final adJumpAddress = url.substring(urlPrefix.length);
  if (adJumpAddress.startsWith(JumpProtocolEnum.video)) {
    final videoId = url.split('=')[1];
    //跳视频播放
    Get.toPlayVideo(videoId: int.parse(videoId));
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.blogger)) {
    final id = url.split('=')[1];
    //跳博主详情
    Get.toBloggerDetail(userId: int.parse(id));
    return;
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.activity)) {
    //跳活动
    final storageService = Get.find<StorageService>();
    final token = storageService.token;

    //防止url里面还有别的= 截取失败
    RegExp reg = RegExp(r'url=([^&]*)');
    var match = reg.firstMatch(url);
    var jumUrl = match?.group(1) ?? '';

    if (jumUrl.contains('?')) {
      jumUrl = '$jumUrl&token=$token';
    } else {
      jumUrl = '$jumUrl?token=$token';
    }

    if (kIsWeb) {
      launchUrlString(
        jumUrl,
        webViewConfiguration: const WebViewConfiguration(),
        browserConfiguration: const BrowserConfiguration(showTitle: true),
      );
      return;
    }
    ddd.Navigator.push(
      Get.context!,
      MaterialPageRoute(builder: (BuildContext context) {
        return AppWebViewPage(
          url: jumUrl,
        );
      }),
    );
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.rech)) {
    //跳会员
    Get.toVip();
    return;
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.wall)) {
    //跳钱包
    Get.toWallet();
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.share)) {
    //跳分享
    Get.toShare();
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.group)) {
    //跳加群
    Get.toNamed(Routes.mineGroup);
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.ai)) {
    //跳AI
    Get.toNamed(Routes.aiHome);
    return;
  }
}

///在线客服
void kOnLineService({String onLineServiceUrl = ""}) {
  String url = onLineServiceUrl;
  if (url == "" || url.trim().isEmpty) {
    final address = Get.find<StorageService>().onlineAPI ?? '';
    if (address.isEmpty) return;
    url = (Environment.kbaseAPI + address).replaceFirst("api//", "");
  }
  launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(),
    browserConfiguration: const BrowserConfiguration(showTitle: true),
  );
}

void kAdjump(AdInfoModel ad) {
  if (ad.adJump.startsWith(urlPrefix)) {
    //跳内部
    jumpInternalAddress(ad.adJump);
  } else {
    jumpExternalURL(
      ad.adJump,
      adId: ad.adId,
    );
  }
}

Future<FileDownloaderResult> _androidInnerAppDownloadApk(
    String apkURL, ValueCallback? percent) async {
  // SmartDialog.showLoading(msg: "下载中:0%", alignment: Alignment.center);
  final res = await filedownloader.downloadMediaFile(apkURL,
      onProgress: (count, total) {
    final percentage = (count / total) * 100.0.toDouble();
    percent?.call(percentage);
  });
  return res;
}
