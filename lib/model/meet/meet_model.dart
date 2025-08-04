import 'package:json2dart_safe/json2dart.dart';

class MeetModel {
  int? userId;
  int? meetUserId;
  String? nickName;
  String? logo;
  double? price;
  String? createdAt;
  String? updatedAt;

  MeetModel({
    this.userId,
    this.meetUserId,
    this.nickName,
    this.logo,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('userId', this.userId)
      ..put('meetUserId', this.meetUserId)
      ..put('nickName', this.nickName)
      ..put('logo', this.logo)
      ..put('price', this.price)
      ..put('createdAt', this.createdAt)
      ..put('updatedAt', this.updatedAt);
  }

  MeetModel.fromJson(Map<String, dynamic> json) {
    this.userId = json.asInt('userId');
    this.meetUserId = json.asInt('meetUserId');
    this.nickName = json.asString('nickName');
    this.logo = json.asString('logo');
    this.price = json.asDouble('price');
    this.createdAt = json.asString('createdAt');
    this.updatedAt = json.asString('updatedAt');
  }
}
