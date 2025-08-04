import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/city_model.dart';

class ProvinceModel {
  String? code; //行政编码
  String? createdAt;
  String? updatedAt;
  int? distinctId; //区域Id
  String? name; //区域名称
  List<CityModel>? cityList; //区域城市

  ProvinceModel({
    this.code,
    this.createdAt,
    this.updatedAt,
    this.distinctId,
    this.name,
    this.cityList,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('code', code)
      ..put('createdAt', createdAt)
      ..put('updatedAt', updatedAt)
      ..put('distinctId', distinctId)
      ..put('name', name)
      ..put('cityList', cityList?.map((v) => v.toJson()).toList());
  }

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    code = json.asString('code');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
    distinctId = json.asInt('distinctId');
    name = json.asString('name');
    cityList = json.asList<CityModel>('cityList', CityModel.toBean);
  }

  static ProvinceModel toBean(dynamic json) => ProvinceModel.fromJson(json);
}
