import 'package:json2dart_safe/json2dart.dart';

class SearchTopicModel {
  String? id;
  String? name;
  String? logo;
  int? postNum;
  int? watchNum;
  int? subscribeNum;
  bool? hot;
  bool? subscribe;

  SearchTopicModel({
    id,
    name,
    logo,
    postNum,
    watchNum,
    subscribeNum,
    hot,
    subscribe,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('name', name)
      ..put('logo', logo)
      ..put('postNum', postNum)
      ..put('watchNum', watchNum)
      ..put('subscribeNum', subscribeNum)
      ..put('hot', hot)
      ..put('subscribe', subscribe);
  }

  SearchTopicModel.fromJson(Map<dynamic, dynamic> json) {
    id = json.asString('id');
    name = json.asString('name');
    logo = json.asString('logo');
    postNum = json.asInt('postNum');
    watchNum = json.asInt('watchNum');
    subscribeNum = json.asInt('subscribeNum');
    hot = json.asBool('hot');
    subscribe = json.asBool('subscribe');
  }

  static SearchTopicModel toBean(Map<String, dynamic> json) =>
      SearchTopicModel.fromJson(json);
}
