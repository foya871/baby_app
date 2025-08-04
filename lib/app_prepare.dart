import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:http_service/http_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import 'components/base_refresh/base_refresh_style.dart';
import 'components/image_view.dart';
import 'env/environment_service.dart';
import 'hive/hive_registrar.g.dart';
import 'http/service/api_settings.dart';
import 'services/app_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';
import 'utils/color.dart';
import 'utils/conditional_future.dart';
import 'utils/logger.dart';
import 'utils/uuid.dart';
import 'views/player/play_center_dispatch.dart';

class AppPrepare {
  AppPrepare._();

  static _getDeviceInfo() async {
    var info = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final dname = androidInfo.brand;
      final name = androidInfo.device;
      final model = androidInfo.model;
      final brand = androidInfo.display;
      final version = androidInfo.version.sdkInt;
      info = '$dname/$name/$model/$brand/android_version=$version';
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final name = iosInfo.name;
      final model = iosInfo.model;
      final brand = iosInfo.systemName;
      final version = iosInfo.systemVersion;
      info = '$name/$model/$brand/ios_version=$version';
    }
    final localStore = Get.find<StorageService>();
    await localStore.updateDeviceInfo(info);
  }

  static Future<void> init() async {
    _setGlobalEasyRefresh();
    Hive.registerAdapters();
    await Get.putAsync(() => StorageService().init());
    await _initDeviceId();

    if (!kIsWeb) await _getDeviceInfo();

    _initHttpService();
    _initShortVideoMudle();

    _initServices();
  }

  static void _initShortVideoMudle() => ShortVideoMudle.ensureInitialized(
        logger: logger.d,
        enableM3u8DownloadLog: Environment.enableM3u8DownloadLog,
        networkImageBuilder: ImageView.shortVideoMudleBuilder,
        m3u8RecordStorage: Get.find<StorageService>(),
        m3u8RequestHeaderGetter: ApiRequestInterceptor.buildHeaders,
        themeColor: COLOR.themeSelectedColor,
      );

  static void _initHttpService() => HttpService.ensureInitialized(
        logger: logger.d,
        settings: ApiSettings(),
      );

  static Future<void> _initDeviceId() async {
    final localStore = Get.find<StorageService>();

    String? deviceId = localStore.deviceId;

    if (deviceId == null) {
      if (GetPlatform.isWeb) {
        deviceId = UUID.generate();
      } else {
        deviceId = (await DeviceUuid().getUUID() ?? '').trim();
      }
      if (deviceId.isEmpty) {
        // ??
        exit(1);
      }
      await localStore.setDeviceId(deviceId);
    }
    logger.d('deviceId: ${localStore.deviceId}');
  }

  static void _initServices() {
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => PlayCenterDispatch());
    Get.lazyPut(() => AppService());
  }

  ///选线
  static Future<void> chooseAPILines([List<String>? apis]) async {
    const String suffix = "sys/live";
    apis ??= Environment.apiList;
    if (apis.isEmpty) return;
    final option = BaseOptions(connectTimeout: const Duration(seconds: 15));
    final dio = Dio(option);
    final fs = apis.map((item) async {
      try {
        return await dio.get("$item/api/$suffix");
      } catch (e) {
        return Future.value(null);
      }
    }).toList();
    final storageService = Get.find<StorageService>();

    final res = await ConditionalFuture<Response?>(
      fs,
      (res) =>
          res != null &&
          res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300,
    ).any();
    if (res != null) {
      final line = '${res.realUri.origin}/api/';
      logger.d('chooseLine success >>>>> $line');
      Environment.androidiOSAPI = line;
      storageService.setLastSuccessDomain(line);
    } else if (Environment.backupApisJsonURL.isNotEmpty) {
      await _getBackupApisJson(dio);
    }
  }

  static _getBackupApisJson(Dio dio) async {
    final backupResponses = await Future.wait(
      Environment.backupApisJsonURL.map((item) async {
        try {
          final response = await dio.get(item);
          if (response.data != null) {
            return List<String>.from(response.data);
          }
        } catch (e) {
          return null;
        }
        return null;
      }),
    );
    // 获取并更新成功的备份 API 地址
    final backupApis = backupResponses.whereType<List<String>>().toList();
    if (backupApis.isNotEmpty) {
      await chooseAPILines(backupApis.first);
    }
  }

  static void _setGlobalEasyRefresh() {
    EasyRefresh.defaultHeaderBuilder = BaseRefreshStyle.defaultHeaderBuilder;
    EasyRefresh.defaultFooterBuilder = BaseRefreshStyle.defaultFooterBuilder;
  }
}
