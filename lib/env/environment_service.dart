/*
 * @Author: wangdazhuang
 * @Date: 2024-08-01 17:22:04
 * @LastEditTime: 2025-07-10 20:02:57
 * @LastEditors: wdz
 * @FilePath: /baby_app/lib/env/environment_service.dart
 */

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class Environment {
  static get enableM3u8DownloadLog => false;

  static get enableAPiLog => true;

  static get _useDevApi => kDebugMode;

  static List<String> get _proList => [
        getRandomFanDomain("*.2mvhdau1i.xyz"),
        getRandomFanDomain("*.2peubhyzx.xyz"),
        getRandomFanDomain("*.33usxvh2b.xyz"),
        getRandomFanDomain("*.3knw3ncjw.xyz"),
        getRandomFanDomain("*.3kucbzus2.xyz"),
        getRandomFanDomain("*.42c64t4i5.xyz"),
      ];

  static List<String> get _testLines => [
        'http://118.107.45.22:9901',
      ];

  static List<String> get apiList {
    if (_useDevApi) {
      return [
        ///debug测试
        // ..._testLines,

        ///debug正式
        ..._proList
      ];
    } else {
      return [
        /// 线上正式
        ..._proList
      ];
    }
  }

  ///*. 随意的字符串
  // static String get fanDomain => "*.yrqwlhmphi.work";

  static List<String> get backupApisJsonURL {
    if (_useDevApi) {
      return [];
    } else {
      return [
        "https://d24ss14olgeo2v.cloudfront.net/snbs.json",
        "https://d29uv9ovkwrrc2.cloudfront.net/snbs_ldy.json",
      ];
    }
  }

  ///备用官方邮箱
  static String get backupOfficialEmail => 'dyjm2016@gmail.com';

  ///备用落地页json
  static String get backupOfficialAddressJson => "";

  static String getRandomFanDomain(String fanDomain) {
    String domain = fanDomain;
    // 随机生成 3 到 5 位的小写字母
    final Random random = Random();
    final int length = random.nextInt(3) + 3;
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    // 生成随机小写字母字符串
    String randomString = List.generate(length, (index) {
      return chars[random.nextInt(chars.length)];
    }).join();

    // 将随机生成的字母字符串拼接到域名后
    String newDomain = "https://$randomString.${domain.substring(2)}";

    return newDomain;
  }

  static String androidiOSAPI = '';

  ///选线成功 web平台默认true
  static bool get apiLinesOk => GetPlatform.isWeb || androidiOSAPI.isNotEmpty;

  static String get kbaseAPI {
    String address = '';
    if (kIsWeb) {
      if (kDebugMode) {
        address = 'http://localhost:5268';
        // address = "http://192.168.1.120:5268";
        const addressEnv = String.fromEnvironment('__WEB_PROXY_ADDRESS__');
        if (addressEnv.isNotEmpty && addressEnv.startsWith('http://192.')) {
          address = addressEnv;
        }
      }
    }
    return kIsWeb ? '$address/api/' : androidiOSAPI;
  }

  static String buildAuthPlayUrlString(
          {String? videoUrl, String? authKey, String? id}) =>
      '${kbaseAPI}m3u8/decode/authPath?path=${videoUrl ?? ''}&auth_key=${authKey ?? ''}${id == null ? '' : '&id='}${id ?? ''}';

  static Uri? tryBuildAuthPlayUrl(
          {String? videoUrl, String? authKey, String? id}) =>
      Uri.tryParse(
          buildAuthPlayUrlString(videoUrl: videoUrl, authKey: authKey, id: id));

  static Uri buildAuthPlayUrl(
          {String? videoUrl, String? authKey, String? id}) =>
      Uri.parse(
          buildAuthPlayUrlString(videoUrl: videoUrl, authKey: authKey, id: id));
}
