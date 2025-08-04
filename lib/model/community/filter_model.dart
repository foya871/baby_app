import 'package:json2dart_safe/json2dart.dart';

class FilterModel {
  String? name;
  int? type;

  FilterModel.add(String this.name, int this.type);

  FilterModel({this.name, this.type});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('name', name)
      ..put('type', type);
  }

  FilterModel.fromJson(Map<String, dynamic> json) {
    name = json.asString('name');
    type = json.asInt('type');
  }

  static FilterModel toBean(dynamic json) => FilterModel.fromJson(json);
}
