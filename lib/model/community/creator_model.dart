import 'package:json2dart_safe/json2dart.dart';

class CreatorModel {
  int? userId;
  String? nickName;
  String? logo;
  String? cityName;
  String? personSign;
  int? vipType;
  int? age;
  int? gender; //用户性别 1-女,2-男,3-保密

  CreatorModel({
    this.userId,
    this.nickName,
    this.logo,
    this.cityName,
    this.personSign,
    this.vipType,
    this.age,
    this.gender,
  });

  int get ageInt => (age ?? 0) == 0 ? 16 : age!;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('userId', userId)
      ..put('nickName', nickName)
      ..put('logo', logo)
      ..put('cityName', cityName)
      ..put('personSign', personSign)
      ..put('vipType', vipType)
      ..put('age', age)
      ..put('gender', gender);
  }

  CreatorModel.fromJson(Map<String, dynamic> json) {
    userId = json.asInt('userId');
    nickName = json.asString('nickName');
    logo = json.asString('logo');
    cityName = json.asString('cityName');
    personSign = json.asString('personSign');
    vipType = json.asInt('vipType');
    age = json.asInt('age');
    gender = json.asInt('gender');
  }

  static CreatorModel toBean(dynamic json) => CreatorModel.fromJson(json);
}
