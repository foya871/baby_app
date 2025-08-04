import 'package:json2dart_safe/json2dart.dart';

class ProxyRecordModel {
  String? createdAt; //推广时间
  String? ownerLogo; //头像
  String? ownerNickName; //用户昵称
  int? userId;

  ProxyRecordModel({this.createdAt, this.ownerLogo, this.ownerNickName, this.userId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt', createdAt)
      ..put('ownerLogo', ownerLogo)
      ..put('ownerNickName', ownerNickName)
      ..put('userId', userId);
  }

  ProxyRecordModel.fromJson(Map<String, dynamic> json) {
    createdAt = json.asString('createdAt');
    ownerLogo = json.asString('ownerLogo');
    ownerNickName = json.asString('ownerNickName');
    userId = json.asInt('userId');
  }

  dynamic toBean(Map<String, dynamic> json) => ProxyRecordModel.fromJson(json);
}
