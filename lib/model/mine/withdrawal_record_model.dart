/*
 * @description: 
 * @FilePath: /baby_app/lib/model/mine/withdrawal_record_model.dart
 * @author: david
 * @文件版本: V1.0.0
 * @Date: 2025-06-28 15:49:07
 * 版权信息: 2025 by david, All Rights Reserved.
 */
import 'package:json2dart_safe/json2dart.dart';

class WithdrawalRecordModel {
  String? tradeNo;
  int? userId;
  String? nickName;
  String? ip;
  int? payType;
  int? purType;
  double? money;
  double? moneyAdmin;
  int? platformId;
  String? platformName;
  String? receiptName;
  String? accountNo;
  int? status;
  int? verifyStatus;
  int? withdrawSource;
  String? deviceId;
  String? device;
  int? ratio;
  String? createdAt;
  String? updatedAt;

  WithdrawalRecordModel({
    this.tradeNo,
    this.userId,
    this.nickName,
    this.ip,
    this.payType,
    this.purType,
    this.money,
    this.moneyAdmin,
    this.platformId,
    this.platformName,
    this.receiptName,
    this.accountNo,
    this.status,
    this.verifyStatus,
    this.withdrawSource,
    this.deviceId,
    this.device,
    this.ratio,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('tradeNo', this.tradeNo)
      ..put('userId', this.userId)
      ..put('nickName', this.nickName)
      ..put('ip', this.ip)
      ..put('payType', this.payType)
      ..put('purType', this.purType)
      ..put('money', this.money)
      ..put('moneyAdmin', this.moneyAdmin)
      ..put('platformId', this.platformId)
      ..put('platformName', this.platformName)
      ..put('receiptName', this.receiptName)
      ..put('accountNo', this.accountNo)
      ..put('status', this.status)
      ..put('verifyStatus', this.verifyStatus)
      ..put('withdrawSource', this.withdrawSource)
      ..put('deviceId', this.deviceId)
      ..put('device', this.device)
      ..put('ratio', this.ratio)
      ..put('createdAt', this.createdAt)
      ..put('updatedAt', this.updatedAt);
  }

  WithdrawalRecordModel.fromJson(Map<String, dynamic> json) {
    this.tradeNo = json.asString('tradeNo');
    this.userId = json.asInt('userId');
    this.nickName = json.asString('nickName');
    this.ip = json.asString('ip');
    this.payType = json.asInt('payType');
    this.purType = json.asInt('purType');
    this.money = json.asDouble('money');
    this.moneyAdmin = json.asDouble('moneyAdmin');
    this.platformId = json.asInt('platformId');
    this.platformName = json.asString('platformName');
    this.receiptName = json.asString('receiptName');
    this.accountNo = json.asString('accountNo');
    this.status = json.asInt('status');
    this.verifyStatus = json.asInt('verifyStatus');
    this.withdrawSource = json.asInt('withdrawSource');
    this.deviceId = json.asString('deviceId');
    this.device = json.asString('device');
    this.ratio = json.asInt('ratio');
    this.createdAt = json.asString('createdAt');
    this.updatedAt = json.asString('updatedAt');
  }

  static WithdrawalRecordModel toBean(Map<String, dynamic> json) =>
      WithdrawalRecordModel.fromJson(json);
}
