import 'package:json2dart_safe/json2dart.dart';

class WithdrawConfigModel {
  double? balaRate;
  double? goldRate;
  double? maxQuota;
  double? minQuota;
  int? payType;

  WithdrawConfigModel({
    this.balaRate,
    this.goldRate,
    this.maxQuota,
    this.minQuota,
    this.payType,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('balaRate', this.balaRate)
      ..put('goldRate', this.goldRate)
      ..put('maxQuota', this.maxQuota)
      ..put('minQuota', this.minQuota)
      ..put('payType', this.payType);
  }

  WithdrawConfigModel.fromJson(Map<String, dynamic> json) {
    this.balaRate = json.asDouble('balaRate');
    this.goldRate = json.asDouble('goldRate');
    this.maxQuota = json.asDouble('maxQuota');
    this.minQuota = json.asDouble('minQuota');
    this.payType = json.asInt('payType');
  }

  static WithdrawConfigModel toBean(Map<String, dynamic> json) =>
      WithdrawConfigModel.fromJson(json);
}
