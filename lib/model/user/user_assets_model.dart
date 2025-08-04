/*
 * @Author: wangdazhuang
 * @Date: 2024-08-27 21:06:20
 * @LastEditTime: 2024-08-27 21:07:48
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/model/user/user_assets_model.dart
 */

import 'package:json2dart_safe/json2dart.dart';

class UseAssetsModel {
  double? bala;
  double? gold;
  double? integral;

  UseAssetsModel({
    this.bala,
    this.gold,
    this.integral,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bala', this.bala)
      ..put('gold', this.gold)
      ..put('integral', this.integral);
  }

  UseAssetsModel.fromJson(Map<String, dynamic> json) {
    this.bala = json.asDouble('bala');
    this.gold = json.asDouble('gold');
    this.integral = json.asDouble('integral');
  }

  static UseAssetsModel toBean(Map<String, dynamic> json) =>
      UseAssetsModel.fromJson(json);
}
