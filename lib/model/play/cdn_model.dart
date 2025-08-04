/*
 * @Author: wangdazhuang
 * @Date: 2024-09-26 17:25:01
 * @LastEditTime: 2024-09-26 17:25:15
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/model/play/cdn_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class CdnRsp {
  String? id;
  String? line;
  String? mark;
  bool? vip;

  CdnRsp({
    this.id,
    this.line,
    this.mark,
    this.vip,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id', this.id)
      ..put('line', this.line)
      ..put('mark', this.mark)
      ..put('vip', this.vip);
  }

  CdnRsp.fromJson(Map<String, dynamic> json) {
    this.id = json.asString('id');
    this.line = json.asString('line');
    this.mark = json.asString('mark');
    this.vip = json.asBool('vip');
  }

  static CdnRsp toBean(Map<String, dynamic> json) => CdnRsp.fromJson(json);
}
