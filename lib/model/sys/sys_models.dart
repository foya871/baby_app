import 'package:json2dart_safe/json2dart.dart';

class SysBussinessModel {
  final String link;
  final String name;

  SysBussinessModel.empty() : this.fromJson({});

  bool isEmpty() => link == '';

  SysBussinessModel.fromJson(Map<String, dynamic> json)
      : link = json.asString('link'),
        name = json.asString('name');

  static dynamic toBean(dynamic json) => SysBussinessModel.fromJson(json);
}
