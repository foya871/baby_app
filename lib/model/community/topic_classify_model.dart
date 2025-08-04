import 'package:json2dart_safe/json2dart.dart';

class TopicClassifyModel {
  int? classifyId;
  String? name;
  bool? isSelect;

  TopicClassifyModel({
    this.classifyId,
    this.name,
    this.isSelect,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('classifyId', classifyId)
      ..put('name', name)
      ..put('isSelect', isSelect);
  }

  TopicClassifyModel.fromJson(Map<String, dynamic> json) {
    classifyId = json.asInt('classifyId');
    name = json.asString('name');
    isSelect = json.asBool('isSelect');
  }

  static TopicClassifyModel toBean(dynamic json) =>
      TopicClassifyModel.fromJson(json);
}
