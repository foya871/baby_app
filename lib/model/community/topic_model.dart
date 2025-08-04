import 'package:json2dart_safe/json2dart.dart';

class TopicModel {
  String? id;
  String? name;

  TopicModel({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('name', name);
  }

  TopicModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    name = json.asString('name');
  }

  static TopicModel toBean(dynamic json) => TopicModel.fromJson(json);
}
