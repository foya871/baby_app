import 'package:json2dart_safe/json2dart.dart';

class CityModel {
  String? code; //行政编码
  String? initial; //拼音首字母
  bool? isHot; //是否热门
  String? name; //区域名称
  String? parentCode; //父级区域编码
  String? parentName; //父级区域名称
  String? pinyin; //拼音
  String? suffix; //后缀
  int? distinctId; //区域Id
  String? order; //排序

  CityModel.recommend() : name = '最受欢迎';

  CityModel({
    this.code,
    this.initial,
    this.isHot,
    this.name,
    this.parentCode,
    this.parentName,
    this.pinyin,
    this.suffix,
    this.distinctId,
    this.order,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('code', code)
      ..put('initial', initial)
      ..put('isHot', isHot)
      ..put('name', name)
      ..put('parentCode', parentCode)
      ..put('parentName', parentName)
      ..put('pinyin', pinyin)
      ..put('suffix', suffix)
      ..put('distinctId', distinctId)
      ..put('order', order);
  }

  CityModel.fromJson(Map<String, dynamic> json) {
    code = json.asString('code');
    initial = json.asString('initial');
    isHot = json.asBool('isHot');
    name = json.asString('name');
    parentCode = json.asString('parentCode');
    parentName = json.asString('parentName');
    pinyin = json.asString('pinyin');
    suffix = json.asString('suffix');
    distinctId = json.asInt('distinctId');
    order = json.asString('order');
  }

  static CityModel toBean(dynamic json) => CityModel.fromJson(json);
}
