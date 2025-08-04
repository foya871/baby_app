/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-23 14:22:34
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-10 20:14:53
 * @FilePath: /baby_app/lib/http/api/login.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:baby_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:baby_app/utils/logger.dart';
import 'package:http_service/http_service.dart';

//登录
Future<bool> login(String deviceId) async {
  String? params;
  if (kIsWeb) {
    var ppp = Uri.base.queryParameters;
    params = jsonEncode(ppp).toString();
  } else {
    final text = await Clipboard.getData(Clipboard.kTextPlain);
    final content = text?.text;
    if (content != null && content.isNotEmpty) {
      logger.d('text from paste board >>> $content');
    }
    params = content;
  }
  final localStore = Get.find<StorageService>();
  try {
    UserInfo? resp = await httpInstance.post<UserInfo>(
        url: "user/traveler",
        body: {
          "deviceId": deviceId,
          'code': params,
          'chCode': const String.fromEnvironment('CHANNEL'),
        },
        complete: UserInfo.fromJson);
    if (resp == null || resp.token?.isEmpty == true) return false;
    //增加await，解决偶尔获取出现userId = 0 的情况
    await localStore.saveUserInfo(resp);
    return true;
  } catch (_) {
    return false;
  }
}

//拉取广告
Future<bool> fecthAllAds() async {
  try {
    List<AdInfoModel>? ads = await httpInstance.get(
      url: 'all/ad/place/list',
      complete: AdInfoModel.fromJson,
    );
    if (ads == null) return false;
    final localStore = Get.find<StorageService>();
    await localStore.saveAds(ads);
    return true;
  } catch (e) {
    return false;
  }
}
