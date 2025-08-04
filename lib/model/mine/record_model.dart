import 'package:json2dart_safe/json2dart.dart';

class RecordModel {
  double? amount;
  double? rechargeMoney;
  String? createdAt;
  int? mark; //1-收入,2-支出
  String? nikeName;
  String? title;
  String? desc;
  String? tradeNo; //交易订单号
  int? payType; //支付方式 0余额 1支付宝 2微信  3银联
  int? status; //交易状态 0成功 1失败
  int? userId;
  int? tranType;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('amount', amount)
      ..put('rechargeMoney', rechargeMoney)
      ..put('createdAt', createdAt)
      ..put('mark', mark)
      ..put('nikeName', nikeName)
      ..put('title', title)
      ..put('desc', desc)
      ..put('tradeNo', tradeNo)
      ..put('payType', payType)
      ..put('status', status)
      ..put('userId', userId)
      ..put('tranType', tranType);
  }

  RecordModel.fromJson(Map<String, dynamic> json) {
    amount = json.asDouble('amount');
    rechargeMoney = json.asDouble('rechargeMoney');
    createdAt = json.asString('createdAt');
    mark = json.asInt('mark');
    nikeName = json.asString('nikeName');
    title = json.asString('title');
    desc = json.asString('desc');
    tradeNo = json.asString('tradeNo');
    payType = json.asInt('payType');
    status = json.asInt('status');
    userId = json.asInt('userId');
    tranType = json.asInt('tranType');
  }

  dynamic toBean(Map<String, dynamic> json) => RecordModel.fromJson(json);
}
