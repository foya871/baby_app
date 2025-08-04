/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-28 14:53:57
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-09-02 14:06:09
 * @FilePath: /baby_app/lib/src/model/announcement/home_activity.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:baby_app/model/announcement/activity_model.dart';
import 'package:json2dart_safe/json2dart.dart';

class HomeActivityModel {
  List<ActivityModel>? actList;
  ActivityModel? act;

  HomeActivityModel({
    this.actList,
    this.act,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('actList', this.actList?.map((v) => v.toJson()).toList())
      ..put('act', this.act?.toJson());
  }

  HomeActivityModel.fromJson(Map<String, dynamic> json) {
    this.actList = json.asList<ActivityModel>(
        'actList', (v) => ActivityModel.fromJson(Map<String, dynamic>.from(v)));
    this.act = json.asBean(
        'act', (v) => ActivityModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static HomeActivityModel toBean(Map<String, dynamic> json) =>
      HomeActivityModel.fromJson(json);
}
