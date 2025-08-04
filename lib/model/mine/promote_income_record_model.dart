import 'package:json2dart_safe/json2dart.dart';

class PromoteIncomeRecordModel {
  double? amount;
  String? createdAt;
  String? ownerNickName;
  double? rechargeMoney;

  PromoteIncomeRecordModel({
    this.amount,
    this.createdAt,
    this.ownerNickName,
    this.rechargeMoney,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('amount', this.amount)
      ..put('createdAt', this.createdAt)
      ..put('ownerNickName', this.ownerNickName)
      ..put('rechargeMoney', this.rechargeMoney);
  }

  PromoteIncomeRecordModel.fromJson(Map<String, dynamic> json) {
    this.amount = json.asDouble('amount');
    this.createdAt = json.asString('createdAt');
    this.ownerNickName = json.asString('ownerNickName');
    this.rechargeMoney = json.asDouble('rechargeMoney');
  }

  static PromoteIncomeRecordModel toBean(Map<String, dynamic> json) =>
      PromoteIncomeRecordModel.fromJson(json);
}
