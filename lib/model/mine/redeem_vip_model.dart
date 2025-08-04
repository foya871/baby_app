import 'package:json2dart_safe/json2dart.dart';

class RedeemVipModel {
  String? cardName;
  String? enableEndTime;
  String? reCode;
  int? status;
  String? usedTime;
  String? id;
  int? vipDay;

  RedeemVipModel({
    this.cardName,
    this.enableEndTime,
    this.reCode,
    this.status,
    this.usedTime,
    this.id,
    this.vipDay,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('cardName', this.cardName)
      ..put('enableEndTime', this.enableEndTime)
      ..put('reCode', this.reCode)
      ..put('status', this.status)
      ..put('usedTime', this.usedTime)
      ..put('id', this.id)
      ..put('vipDay', this.vipDay);
  }

  RedeemVipModel.fromJson(Map<String, dynamic> json) {
    this.cardName = json.asString('cardName');
    this.enableEndTime = json.asString('enableEndTime');
    this.reCode = json.asString('reCode');
    this.status = json.asInt('status');
    this.usedTime = json.asString('usedTime');
    this.id = json.asString('id');
    this.vipDay = json.asInt('vipDay');
  }

  static RedeemVipModel toBean(Map<String, dynamic> json) =>
      RedeemVipModel.fromJson(json);
}
