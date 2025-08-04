/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-17 21:10:34
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-17 21:41:04
 * @FilePath: /baby_app/lib/src/model/mine/buy_dynamic.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class BuyDynamic {
  String? nickName;
  String? ownerNickName;
  String? createdAt;
  int? amount;
  BuyDynamic({
    this.nickName,
    this.createdAt,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('nickName', this.nickName)
      ..put('nickName', this.ownerNickName)
      ..put('createdAt', this.createdAt)
      ..put('amount', this.amount);
  }

  BuyDynamic.fromJson(Map<String, dynamic> json) {
    this.nickName = json.asString('nickName');
    this.ownerNickName = json.asString('ownerNickName');
    this.createdAt = json.asString('createdAt');
    this.amount = json.asInt('amount');
  }

  static BuyDynamic toBean(Map<String, dynamic> json) =>
      BuyDynamic.fromJson(json);
}
