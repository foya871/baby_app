import 'package:json2dart_safe/json2dart.dart';

class ApplicationPartnerChildModel {
  String? id;
  List<int>? classifyId;
  String? name;
  String? desc;
  String? icon;
  String? link;
  int? sortNum;
  bool? isOpen;
  int? clickNum;
  String? startTime;
  String? stopTime;
  String? remove;
  String? createdAt;
  String? updatedAt;

  ApplicationPartnerChildModel({
    id,
    classifyId,
    name,
    desc,
    icon,
    link,
    sortNum,
    isOpen,
    clickNum,
    startTime,
    stopTime,
    remove,
    createdAt,
    updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('classifyId', classifyId)
      ..put('name', name)
      ..put('desc', desc)
      ..put('icon', icon)
      ..put('link', link)
      ..put('sortNum', sortNum)
      ..put('isOpen', isOpen)
      ..put('clickNum', clickNum)
      ..put('startTime', startTime)
      ..put('stopTime', stopTime)
      ..put('remove', remove)
      ..put('createdAt', createdAt)
      ..put('updatedAt', updatedAt);
  }

  ApplicationPartnerChildModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    classifyId = json.asList<int>('classifyId', null);
    name = json.asString('name');
    icon = json.asString('icon');
    desc = json.asString('desc');
    link = json.asString('link');
    sortNum = json.asInt('sortNum');
    isOpen = json.asBool('isOpen');
    clickNum = json.asInt('clickNum');
    startTime = json.asString('startTime');
    stopTime = json.asString('stopTime');
    remove = json.asString('remove');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
  }

  static ApplicationPartnerChildModel toBean(Map<String, dynamic> json) =>
      ApplicationPartnerChildModel.fromJson(json);
}
