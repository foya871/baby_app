import 'package:json2dart_safe/json2dart.dart';

class BloggerBaseModel {
  int? userId;
  String? nickName;
  String? logo;
  String? cityName;
  String? distance;
  bool? online;
  bool? attention;
  String? longitude;
  String? latitude;
  int? chatVipType;
  int? dynNum;
  int? workNum;

  BloggerBaseModel.add(String this.nickName);

  BloggerBaseModel({
    this.userId,
    this.nickName,
    this.logo,
    this.cityName,
    this.distance,
    this.online,
    this.attention,
    this.longitude,
    this.latitude,
    this.chatVipType,
    this.dynNum,
    this.workNum,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('userId', userId)
      ..put('nickName', nickName)
      ..put('logo', logo)
      ..put('cityName', cityName)
      ..put('distance', distance)
      ..put('online', online)
      ..put('attention', attention)
      ..put('longitude', longitude)
      ..put('latitude', latitude)
      ..put('vipType', chatVipType)
      ..put('dynNum', dynNum)
      ..put('workNum', workNum);
  }

  BloggerBaseModel.fromJson(Map<String, dynamic> json) {
    userId = json.asInt('userId');
    nickName = json.asString('nickName');
    logo = json.asString('logo');
    cityName = json.asString('cityName');
    distance = json.asString('distance');
    online = json.asBool('online');
    attention = json.asBool('attention');
    longitude = json.asString('longitude');
    latitude = json.asString('latitude');
    chatVipType = json.asInt("chatVipType");
    dynNum = json.asInt("dynNum");
    workNum = json.asInt("workNum");
  }

  static BloggerBaseModel toBean(dynamic json) =>
      BloggerBaseModel.fromJson(json);
}
