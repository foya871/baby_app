import 'package:json2dart_safe/json2dart.dart';

class SysPartnerTypeModel {
  String? name;
  int? code;

  SysPartnerTypeModel({
    this.name,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('name', this.name)
      ..put('code', this.code);
  }

  SysPartnerTypeModel.fromJson(Map<String, dynamic> json) {
    this.name = json.asString('name');
    this.code = json.asInt('code');
  }

  static SysPartnerTypeModel toBean(Map<String, dynamic> json) =>
      SysPartnerTypeModel.fromJson(json);
}
