/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-16 16:33:01
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-05 10:28:13
 * @FilePath: /baby_app/lib/services/storage_service.dart
 */
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:baby_app/hive/hive_registrar.g.dart';
import 'package:baby_app/components/ad/ad_info_model.dart';
import 'package:baby_app/model/user/user_info_model.dart';
import 'package:baby_app/utils/consts.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../utils/m3u8_download/m3u8_download_record.dart';

enum StorageKey {
  //上次成功的域名
  lastSuccessDomain('last_success_domain'),
  deviceId('deviceId'),
  token('token'),
  imageDomain('imageDomain'),
  deviceInfo('deviceInfo'),
  //搜索记录
  history('history'),

  //我的页面 是否第一次
  isMineFirst('isMineFirst'),

  //注册密码
  registPassword('registPassword'),

  //资源搜索记录
  resourceSearchHistory('resourceSearchHistory'),

  ///在线客服
  oneLineAddress('oneLineAddress'),

  //广告
  advertisement('advertisement'),
  //用户信息
  userInfo('userInfo'),
  m3u8RecordNextId('m3u8RecordNextId'),

  //
  shortSettingPlaySpeed('shortSettingPlaySpeed'),
  shortSettingAutoNext('shortSettingAutoNext'),
  shortSettingInquiry('shortSettingInquiry'),
  ;

  const StorageKey(this.name);

  final String name;

  @override
  String toString() => name;
}

class StorageService extends GetxService
    implements IM3u8DownloadRecordStorage<M3u8DownloadRecord> {
  late final Box _box;
  late final Box<M3u8DownloadRecord> _m3u8Box;

  Future<bool> deleteBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
      return true; // 删除成功
    } catch (e) {
      return false; // 删除失败
    }
  }

  Future<bool> clearLocal() async {
    try {
      await Hive.deleteFromDisk();
      return true; // 删除成功
    } catch (e) {
      return false; // 删除失败
    }
  }

  /// 初始化 StorageService 工具类, 并返回类实例
  Future<StorageService> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(
      Consts.generalBoxName,
      encryptionCipher: HiveAesCipher(Consts.generalBoxKey),
    );

    ///m3u8下载记录存储
    _m3u8Box = await Hive.openBox<M3u8DownloadRecord>(
      Consts.m3u8DownloaderBoxName,
      encryptionCipher: HiveAesCipher(Consts.generalBoxKey),
    );

    return this;
  }

  ValueListenable<Box> listenable(List<StorageKey>? keys) =>
      _box.listenable(keys: keys?.map((e) => e.name).toList());

  StreamSubscription<BoxEvent> listen(
          StorageKey key, ValueCallback<BoxEvent> onData) =>
      _box.watch(key: key.name).listen(onData);

  T? _read<T>(StorageKey key) => _box.get(key.name);

  Future<void> _write<T>(StorageKey key, T value) => _box.put(key.name, value);

  Future<void> _writeIfNotEqual<T>(StorageKey key, T value,
      {bool Function(T? current)? equal}) async {
    final current = _read(key);
    if (current != null) {
      if (equal != null) {
        if (equal(current)) return;
      } else {
        if (value == current) return;
      }
    }
    return _write(key, value);
  }

  Future<void> _delete(StorageKey key) => _box.delete(key.name);

  // deviceId
  String? get deviceId => _read(StorageKey.deviceId);

  Future<void> setDeviceId(String v) => _write(StorageKey.deviceId, v);

// 在线客服
  String? get onlineAPI => _read(StorageKey.oneLineAddress);

  Future<void> setOneLineApI(String v) => _write(StorageKey.oneLineAddress, v);

  // token
  String? get token => _read(StorageKey.token);

  Future<void> setToken(String v) => _write(StorageKey.token, v);

  Future<void> deleteToken() => _delete(StorageKey.token);

// 图片域名
  String? get imgDomain => _read(StorageKey.imageDomain);

  Future<void> setDomain(String v) => _write(StorageKey.imageDomain, v);

  Future<void> deleteImageDomain() => _delete(StorageKey.imageDomain);

  ///ads
  List<AdInfoModel>? get ads {
    final jsons = _read(StorageKey.advertisement);
    if (jsons == null) return null;
    if (jsons is List<Map>) {
      final items = jsons
          .map((e) => AdInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return items;
    }
    return null;
  }

  Future<void> saveAds(List<AdInfoModel> items) async {
    await _write(
        StorageKey.advertisement, items.map((e) => e.toJson()).toList());
  }

  dynamic get userInfo => _read(StorageKey.userInfo);

  Future<void> saveUserInfo(UserInfo v) async {
    final domain = v.imgDomain ?? '';
    final token = v.token ?? '';
    //保存图片域名
    if (domain.isNotEmpty) {
      setDomain(v.imgDomain ?? '');
    }
    //保存token
    if (token.isNotEmpty) {
      setToken(token);
    }

    await _write(StorageKey.userInfo, v.toJson());
  }

  //history
  List<String> get history => _read(StorageKey.history) ?? [];

  Future<void> setHistory(String v) async {
    var historyList = history;
    if (!historyList.contains(v)) {
      historyList.insert(0, v);
    }
    await _write(StorageKey.history, historyList);
  }

  Future<void> deleteHistory() => _delete(StorageKey.history);

  Future<void> deleteHistoryKey(String key) async {
    var historyList = history;
    if (historyList.contains(key)) {
      historyList.remove(key);
    }
    await _write(StorageKey.history, historyList);
  }

  //域名列表domains
  String get getLastSuccessDomain => _read(StorageKey.lastSuccessDomain) ?? "";

  Future<void> setLastSuccessDomain(String v) =>
      _write(StorageKey.lastSuccessDomain, v);

  /// 资源搜索记录
  List<String> get resourceSearchHistory =>
      _read(StorageKey.resourceSearchHistory) ?? [];

  /// 资源搜索记录
  Future<void> setResourceSearchHistory(String v) async {
    if (!resourceSearchHistory.contains(v)) {
      resourceSearchHistory.insert(0, v);
    }
    await _write(StorageKey.resourceSearchHistory, resourceSearchHistory);
  }

  /// 资源搜索记录
  Future<void> deleteResourceSearchHistory() =>
      _delete(StorageKey.resourceSearchHistory);

  ///我的页面是否第一次的字段
  bool get isMineFirst => _read(StorageKey.isMineFirst) ?? false;

  Future<void> saveMineFirst(bool v) async {
    await _write(StorageKey.isMineFirst, v);
  }

  ///注册密码
  String get registerPassword => _read(StorageKey.registPassword) ?? '';

  Future<void> saveRegisterPassword(String v) async {
    await _write(StorageKey.registPassword, v);
  }

// deviceInfo
  String? get deviceInfo => _read(StorageKey.deviceInfo);

  Future<void> updateDeviceInfo(String v) => _write(StorageKey.deviceInfo, v);

  Future<void> setShortSettings({
    double? playSpeed,
    bool? autoNext,
    bool? isInquiry,
  }) async {
    if (playSpeed != null) {
      await _writeIfNotEqual(StorageKey.shortSettingPlaySpeed, playSpeed);
    }
    if (autoNext != null) {
      await _writeIfNotEqual(StorageKey.shortSettingAutoNext, autoNext);
    }
    if (isInquiry != null) {
      await _writeIfNotEqual(StorageKey.shortSettingInquiry, isInquiry);
    }
  }

  double get shortSettingPlaySpeed =>
      _read(StorageKey.shortSettingPlaySpeed) ?? 1.0;

  bool get shortSettingAutoNext =>
      _read(StorageKey.shortSettingAutoNext) ?? false;

  bool get shortSettingInquiry => _read(StorageKey.shortSettingInquiry) ?? true;

// =============m3u8Box Start==========

  @override
  List<M3u8DownloadRecord> getM3u8RecordsAll() => _m3u8Box.values.toList();

  @override
  M3u8DownloadRecord? getM3u8RecordById(int videoId) => _m3u8Box.get(videoId);

  @override
  Future<void> deleteM3u8RecordById(int videoId) => _m3u8Box.delete(videoId);

  @override
  Future<void> saveM3u8Record(M3u8DownloadRecord record) =>
      _m3u8Box.put(record.videoId, record);
}
