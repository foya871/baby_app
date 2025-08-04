import 'package:json2dart_safe/json2dart.dart';

class ShareRecordModel {
  String? createdAt; //推广时间
  String? logo; //头像
  String? nickName; //用户昵称
  int? userId;

  ShareRecordModel({this.createdAt, this.logo, this.nickName, this.userId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt', createdAt)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('userId', userId);
  }

  ShareRecordModel.fromJson(Map<String, dynamic> json) {
    createdAt = json.asString('createdAt');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    userId = json.asInt('userId');
  }

  dynamic toBean(Map<String, dynamic> json) => ShareRecordModel.fromJson(json);
}
