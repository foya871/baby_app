import 'package:json2dart_safe/json2dart.dart';
import 'station.dart';

class PartnerList {
  String? apkLink;
  String? desc;
  int? clickNum;
  String? createdAt;
  String? icon;
  String? id;
  String? innerLink;
  bool? isOpen;
  int? labelType;
  String? link;
  String? name;
  String? protocolLink;
  bool? remove;
  int? sortNum;
  String? startTime;
  List<Station>? stations;
  String? stopTime;
  int? type;
  String? updatedAt;

  PartnerList({
    this.apkLink,
    this.desc,
    this.clickNum,
    this.createdAt,
    this.icon,
    this.id,
    this.innerLink,
    this.isOpen,
    this.labelType,
    this.link,
    this.name,
    this.protocolLink,
    this.remove,
    this.sortNum,
    this.startTime,
    this.stations,
    this.stopTime,
    this.type,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('apkLink', this.apkLink)
      ..put('desc', this.desc)
      ..put('clickNum', this.clickNum)
      ..put('createdAt', this.createdAt)
      ..put('icon', this.icon)
      ..put('id', this.id)
      ..put('innerLink', this.innerLink)
      ..put('isOpen', this.isOpen)
      ..put('labelType', this.labelType)
      ..put('link', this.link)
      ..put('name', this.name)
      ..put('protocolLink', this.protocolLink)
      ..put('remove', this.remove)
      ..put('sortNum', this.sortNum)
      ..put('startTime', this.startTime)
      ..put('stations', this.stations?.map((e) => e.toJson()).toList())
      ..put('stopTime', this.stopTime)
      ..put('type', this.type)
      ..put('updatedAt', this.updatedAt);
  }

  PartnerList.fromJson(Map<String, dynamic> json) {
    this.apkLink = json.asString('apkLink');
    this.desc = json.asString('desc');
    this.clickNum = json.asInt('clickNum');
    this.createdAt = json.asString('createdAt');
    this.icon = json.asString('icon');
    this.id = json.asString('id');
    this.innerLink = json.asString('innerLink');
    this.isOpen = json.asBool('isOpen');
    this.labelType = json.asInt('labelType');
    this.link = json.asString('link');
    this.name = json.asString('name');
    this.protocolLink = json.asString('protocolLink');
    this.remove = json.asBool('remove');
    this.sortNum = json.asInt('sortNum');
    this.startTime = json.asString('startTime');
    this.stations = json.asList<Station>(
        'stations', (e) => Station.fromJson(e as Map<String, dynamic>));
    this.stopTime = json.asString('stopTime');
    this.type = json.asInt('type');
    this.updatedAt = json.asString('updatedAt');
  }

  static PartnerList toBean(Map<String, dynamic> json) =>
      PartnerList.fromJson(json);
}
