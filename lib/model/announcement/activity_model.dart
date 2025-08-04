/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-26 17:09:47
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-26 17:10:01
 * @FilePath: /baby_app/lib/src/model/activity/activity_model.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:baby_app/utils/utils.dart';
import 'package:json2dart_safe/json2dart.dart';

class ActivityModel {
  String? actEndAt;
  int? actId;
  String? actInitiator;
  String? actRemark;
  String? actReward;
  String? actRule;
  String? actScope;
  String? actStartAt;
  String? actSubTitle;
  String? actTitle;
  String? actUrl;
  String? altPicture;
  String? coverPicture;
  String? createdAt;
  String? id;
  int? jumpType;
  int? status;
  int? type;
  int? joinNum;
  int? countDown;
  int? activityStatus;
  String? updatedAt;
  List<String>? dynamicMsgs;
  int? weight;

  ActivityModel({
    this.actEndAt,
    this.actId,
    this.actInitiator,
    this.actRemark,
    this.actReward,
    this.actRule,
    this.actScope,
    this.actStartAt,
    this.actSubTitle,
    this.actTitle,
    this.actUrl,
    this.altPicture,
    this.coverPicture,
    this.createdAt,
    this.id,
    this.jumpType,
    this.status,
    this.type,
    this.countDown,
    this.joinNum,
    this.activityStatus,
    this.updatedAt,
    this.dynamicMsgs,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('actEndAt', this.actEndAt)
      ..put('actId', this.actId)
      ..put('actInitiator', this.actInitiator)
      ..put('actRemark', this.actRemark)
      ..put('countDown', this.countDown)
      ..put('actReward', this.actReward)
      ..put('actRule', this.actRule)
      ..put('actScope', this.actScope)
      ..put('actStartAt', this.actStartAt)
      ..put('actSubTitle', this.actSubTitle)
      ..put('actTitle', this.actTitle)
      ..put('actUrl', this.actUrl)
      ..put('altPicture', this.altPicture)
      ..put('coverPicture', this.coverPicture)
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('jumpType', this.jumpType)
      ..put('status', this.status)
      ..put('type', this.type)
      ..put('joinNum', this.joinNum)
      ..put('activityStatus', this.activityStatus)
      ..put('updatedAt', this.updatedAt)
      ..put('dynamicMsgs', this.dynamicMsgs)
      ..put('weight', this.weight);
  }

  ActivityModel.fromJson(Map<String, dynamic> json) {
    this.actEndAt = json.asString('actEndAt');
    this.actId = json.asInt('actId');
    this.actInitiator = json.asString('actInitiator');
    this.actRemark = json.asString('actRemark');
    this.actReward = json.asString('actReward');
    this.actRule = json.asString('actRule');
    this.actScope = json.asString('actScope');
    this.actStartAt = json.asString('actStartAt');
    this.actSubTitle = json.asString('actSubTitle');
    this.actTitle = json.asString('actTitle');
    this.actUrl = json.asString('actUrl');
    this.altPicture = json.asString('altPicture');
    this.coverPicture = json.asString('coverPicture');
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.jumpType = json.asInt('jumpType');
    this.status = json.asInt('status');
    this.countDown = json.asInt('countDown');
    this.type = json.asInt('type');
    this.joinNum = json.asInt('joinNum');
    this.activityStatus = json.asInt('activityStatus');
    this.updatedAt = json.asString('updatedAt');
    this.dynamicMsgs = json.asList<String>('dynamicMsgs');
    this.weight = json.asInt('weight');
  }

  static ActivityModel toBean(Map<String, dynamic> json) =>
      ActivityModel.fromJson(json);
}

extension ExtActivity on ActivityModel {
  String get activityTime {
    return "活动时间：${Utils.dateFormat(actStartAt ?? "", precision: 'day')} - ${Utils.dateFormat(actEndAt ?? "", precision: 'day')}";
  }
}
