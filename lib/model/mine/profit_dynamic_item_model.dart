/*
 * @Author: wangdazhuang
 * @Date: 2024-10-17 19:28:16
 * @LastEditTime: 2024-10-18 09:34:55
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/model/mine/profit_dynamic_item_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class ProfitDynamicItemModel {
  int? id;
  String? name;
  String? createdAt;
  String? image;
  String? desc;
  double? gold;
  double? returnGold;
  ProfitDynamicItemModel({
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('name', this.name)
      ..put('returnGold', this.returnGold)
      ..put('id', this.id)
      ..put('createdAt', this.createdAt)
      ..put('gold', this.gold)
      ..put('desc', this.desc)
      ..put('image', this.image);
  }

  ProfitDynamicItemModel.fromJson(Map<String, dynamic> json) {
    this.image = json.asString('image');
    this.createdAt = json.asString('createdAt');
    this.name = json.asString('name');
    this.id = json.asInt('id');
    this.desc = json.asString('desc');
    this.gold = json.asDouble('gold');
    this.returnGold = json.asDouble('returnGold');
  }
}
