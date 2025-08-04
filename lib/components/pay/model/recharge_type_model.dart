import 'package:json2dart_safe/json2dart.dart';

class RechargeTypeModel {
  final String name;

  ///余额支付：0001  支付宝支付：1001   微信支付：1002   银联支付：1003
  final String payMent;
  final String type;

  bool get isEmpty => payMent == "";

  bool get isBalance => payMent == "0001";

  bool get isAlipay => payMent == "1001";

  bool get isWechat => payMent == "1002";

  bool get isUnion => payMent == "1003";

  RechargeTypeModel.empty()
      : name = '',
        payMent = '',
        type = '';

  RechargeTypeModel.balance()
      : name = '余额',
        payMent = "0001",
        type = 'fixedBalance';

  RechargeTypeModel.fromJson(Map<String, dynamic> json)
      : name = json.asString('name'),
        payMent = json.asString('payMent'),
        type = json.asString('type');

  Map<String, dynamic> toJson() => {
        'name': name,
        'payMent': payMent,
        'type': type,
      };

  static dynamic toBean(dynamic json) => RechargeTypeModel.fromJson(json);
}
