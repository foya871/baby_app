/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-28 17:15:15
 * @LastEditors: wdz
 * @LastEditTime: 2025-07-05 10:29:16
 * @FilePath: /baby_app/lib/model/announcement/app_update.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class AppUpdateModel {
  bool? hasNewVersion;
  String? info;
  bool? isForceUpdate;
  String? link;
  int? packageType;
  String? size;
  String? versionNum;

  AppUpdateModel({
    this.hasNewVersion,
    this.info,
    this.isForceUpdate,
    this.link,
    this.packageType,
    this.size,
    this.versionNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('hasNewVersion', this.hasNewVersion)
      ..put('info', this.info)
      ..put('isForceUpdate', this.isForceUpdate)
      ..put('link', this.link)
      ..put('packageType', this.packageType)
      ..put('size', this.size)
      ..put('versionNum', this.versionNum);
  }

  AppUpdateModel.fromJson(Map<String, dynamic> json) {
    this.hasNewVersion = json.asBool("hasNewVersion");
    this.info = json.asString("info");
    this.isForceUpdate = json.asBool('isForceUpdate');
    this.link = json.asString('link');
    this.packageType = json.asInt('packageType');
    this.size = json.asString('size');
    this.versionNum = json.asString("versionNum");
  }

  static AppUpdateModel toBean(Map<String, dynamic> json) =>
      AppUpdateModel.fromJson(json);
}
