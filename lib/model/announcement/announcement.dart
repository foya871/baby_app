/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-28 11:58:05
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-28 11:58:10
 * @FilePath: /baby_app/lib/src/model/announcement/announcement.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class AnnouncementModel {
  int? annId;
  String? annJumpUrl;
  int? annPlatform;
  int? annType;
  String? appCenterUrl;
  String? buttonName;
  String? content;
  String? createdAt;
  String? creator;
  String? endTime;
  String? name;
  String? startTime;
  bool? status;
  String? updatedAt;

  AnnouncementModel({
    this.annId,
    this.annJumpUrl,
    this.annPlatform,
    this.annType,
    this.appCenterUrl,
    this.buttonName,
    this.content,
    this.createdAt,
    this.creator,
    this.endTime,
    this.name,
    this.startTime,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('annId', this.annId)
      ..put('annJumpUrl', this.annJumpUrl)
      ..put('annPlatform', this.annPlatform)
      ..put('annType', this.annType)
      ..put('appCenterUrl', this.appCenterUrl)
      ..put('buttonName', this.buttonName)
      ..put('content', this.content)
      ..put('createdAt', this.createdAt)
      ..put('creator', this.creator)
      ..put('endTime', this.endTime)
      ..put('name', this.name)
      ..put('startTime', this.startTime)
      ..put('status', this.status)
      ..put('updatedAt', this.updatedAt);
  }

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    this.annId = json.asInt('annId');
    this.annJumpUrl = json.asString('annJumpUrl');
    this.annPlatform = json.asInt('annPlatform');
    this.annType = json.asInt('annType');
    this.appCenterUrl = json.asString('appCenterUrl');
    this.buttonName = json.asString('buttonName');
    this.content = json.asString("content");
    this.createdAt = json.asString('createdAt');
    this.creator = json.asString('creator');
    this.endTime = json.asString('endTime');
    this.name = json.asString('name');
    this.startTime = json.asString('startTime');
    this.status = json.asBool('status');
    this.updatedAt = json.asString('updatedAt');
  }

  static AnnouncementModel toBean(Map<String, dynamic> json) =>
      AnnouncementModel.fromJson(json);
}
