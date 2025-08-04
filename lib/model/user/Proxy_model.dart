import 'package:json2dart_safe/json2dart.dart';

class ProxyModel {
  int? todayPromoteBalanceTotal;
  int? todayPromotePersonNum;
  int? monthPromoteBalanceTotal;
  int? monthPromotePersonNum;
  int? bala;
  int? promoteBalanceTotal;
  int? promoteTotalPersonNum;
  int? promotePersonPayNum;

  ProxyModel({
    this.todayPromoteBalanceTotal,
    this.todayPromotePersonNum,
    this.monthPromoteBalanceTotal,
    this.monthPromotePersonNum,
    this.bala,
    this.promoteBalanceTotal,
    this.promoteTotalPersonNum,
    this.promotePersonPayNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('todayPromoteBalanceTotal', this.todayPromoteBalanceTotal)
      ..put('todayPromotePersonNum', this.todayPromotePersonNum)
      ..put('monthPromoteBalanceTotal', this.monthPromoteBalanceTotal)
      ..put('monthPromotePersonNum', this.monthPromotePersonNum)
      ..put('bala', this.bala)
      ..put('promoteBalanceTotal', this.promoteBalanceTotal)
      ..put('promoteTotalPersonNum', this.promoteTotalPersonNum)
      ..put('promotePersonPayNum', this.promotePersonPayNum);
  }

  ProxyModel.fromJson(Map<String, dynamic> json) {
    this.todayPromoteBalanceTotal = json.asInt('todayPromoteBalanceTotal');
    this.todayPromotePersonNum = json.asInt('todayPromotePersonNum');
    this.monthPromoteBalanceTotal = json.asInt('monthPromoteBalanceTotal');
    this.monthPromotePersonNum = json.asInt('monthPromotePersonNum');
    this.bala = json.asInt('bala');
    this.promoteBalanceTotal = json.asInt('promoteBalanceTotal');
    this.promoteTotalPersonNum = json.asInt('promoteTotalPersonNum');
    this.promotePersonPayNum = json.asInt('promotePersonPayNum');
  }

  static ProxyModel toBean(Map<String, dynamic> json) =>
      ProxyModel.fromJson(json);
}
