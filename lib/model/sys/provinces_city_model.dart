import 'package:json2dart_safe/json2dart.dart';

class ProvincesCityModel {
  List<CityModel>? listHot;
  List<CityModel>? listRegion;

  ProvincesCityModel({
    this.listHot,
    this.listRegion,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('listHot', this.listHot?.map((v) => v.toJson()).toList())
      ..put('listRegion', this.listRegion?.map((v) => v.toJson()).toList());
  }

  ProvincesCityModel.fromJson(Map<String, dynamic> json) {
    listHot = json.asList<CityModel>(
        'listHot', (v) => CityModel.fromJson(Map<String, dynamic>.from(v)));
    listRegion = json.asList<CityModel>(
        'listRegion', (v) => CityModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static ProvincesCityModel toBean(Map<String, dynamic> json) =>
      ProvincesCityModel.fromJson(json);
}

class CityModel {
  String? code;
  String? initial;
  bool? isHot;
  String? name;
  String? parentCode;
  String? parentName;
  String? pinyin;
  String? suffix;

  CityModel({
    this.code,
    this.initial,
    this.isHot,
    this.name,
    this.parentCode,
    this.parentName,
    this.pinyin,
    this.suffix,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('code', this.code)
      ..put('initial', this.initial)
      ..put('isHot', this.isHot)
      ..put('name', this.name)
      ..put('parentCode', this.parentCode)
      ..put('parentName', this.parentName)
      ..put('pinyin', this.pinyin)
      ..put('suffix', this.suffix);
  }

  CityModel.fromJson(Map<String, dynamic> json) {
    this.code = json.asString('code');
    this.initial = json.asString('initial');
    this.isHot = json.asBool('isHot');
    this.name = json.asString('name');
    this.parentCode = json.asString('parentCode');
    this.parentName = json.asString('parentName');
    this.pinyin = json.asString('pinyin');
    this.suffix = json.asString('suffix');
  }
}
