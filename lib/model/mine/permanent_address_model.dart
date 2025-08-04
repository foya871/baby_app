import 'package:json2dart_safe/json2dart.dart';

class PermanentAddressModel {
  String? createdAt;
  String? domain;
  String? id;
  String? lineDesc;
  bool? status;
  String? updatedAt;

  PermanentAddressModel({
    this.createdAt,
    this.domain,
    this.id,
    this.lineDesc,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdAt', this.createdAt)
      ..put('domain', this.domain)
      ..put('id', this.id)
      ..put('lineDesc', this.lineDesc)
      ..put('status', this.status)
      ..put('updatedAt', this.updatedAt);
  }

  PermanentAddressModel.fromJson(Map<String, dynamic> json) {
    this.createdAt = json.asString('createdAt');
    this.domain = json.asString('domain');
    this.id = json.asString('id');
    this.lineDesc = json.asString('lineDesc');
    this.status = json.asBool('status');
    this.updatedAt = json.asString('updatedAt');
  }

  static PermanentAddressModel toBean(Map<String, dynamic> json) =>
      PermanentAddressModel.fromJson(json);
}
