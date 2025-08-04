import 'package:json2dart_safe/json2dart.dart';

class PromoteIncomeStatModel {
  int? bala;
  int? monthPromoteBalanceTotal;
  int? monthPromotePersonNum;
  int? promoteBalanceTotal;
  int? promotePersonPayNum;
  int? promoteTotalPersonNum;
  int? todayPromoteBalanceTotal;
  int? todayPromotePersonNum;

  PromoteIncomeStatModel({
    this.bala,
    this.monthPromoteBalanceTotal,
    this.monthPromotePersonNum,
    this.promoteBalanceTotal,
    this.promotePersonPayNum,
    this.promoteTotalPersonNum,
    this.todayPromoteBalanceTotal,
    this.todayPromotePersonNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bala', this.bala)
      ..put('monthPromoteBalanceTotal', this.monthPromoteBalanceTotal)
      ..put('monthPromotePersonNum', this.monthPromotePersonNum)
      ..put('promoteBalanceTotal', this.promoteBalanceTotal)
      ..put('promotePersonPayNum', this.promotePersonPayNum)
      ..put('promoteTotalPersonNum', this.promoteTotalPersonNum)
      ..put('todayPromoteBalanceTotal', this.todayPromoteBalanceTotal)
      ..put('todayPromotePersonNum', this.todayPromotePersonNum);
  }

  PromoteIncomeStatModel.fromJson(Map<String, dynamic> json) {
    this.bala = json.asInt('bala');
    this.monthPromoteBalanceTotal = json.asInt('monthPromoteBalanceTotal');
    this.monthPromotePersonNum = json.asInt('monthPromotePersonNum');
    this.promoteBalanceTotal = json.asInt('promoteBalanceTotal');
    this.promotePersonPayNum = json.asInt('promotePersonPayNum');
    this.promoteTotalPersonNum = json.asInt('promoteTotalPersonNum');
    this.todayPromoteBalanceTotal = json.asInt('todayPromoteBalanceTotal');
    this.todayPromotePersonNum = json.asInt('todayPromotePersonNum');
  }

  static PromoteIncomeStatModel toBean(Map<String, dynamic> json) =>
      PromoteIncomeStatModel.fromJson(json);
}
