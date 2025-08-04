import 'package:json2dart_safe/json2dart.dart';

class TopicSubscribeItemModel {
  String? backgroundImg;
  int? classifyId;
  String? createdAt;
  int? fakeLikeNum;
  int? fakeWatchTimes;
  bool? hot;
  String? id;
  String? introduction;
  String? logo;
  String? name;
  int? postNum;
  int? realLikeNum;
  int? realWatchTimes;
  int? sortNum;
  bool? status;
  String? updatedAt;

  bool isSubscribe = true; //自定义字段。我订阅的话题列表。默认就是已经订阅，所以默认为true

  TopicSubscribeItemModel({
    this.backgroundImg,
    this.classifyId,
    this.createdAt,
    this.fakeLikeNum,
    this.fakeWatchTimes,
    this.hot,
    this.id,
    this.introduction,
    this.logo,
    this.name,
    this.postNum,
    this.realLikeNum,
    this.realWatchTimes,
    this.sortNum,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('backgroundImg', backgroundImg)
      ..put('classifyId', classifyId)
      ..put('createdAt', createdAt)
      ..put('fakeLikeNum', fakeLikeNum)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('hot', hot)
      ..put('id', id)
      ..put('introduction', introduction)
      ..put('logo', logo)
      ..put('name', name)
      ..put('postNum', postNum)
      ..put('realLikeNum', realLikeNum)
      ..put('realWatchTimes', realWatchTimes)
      ..put('sortNum', sortNum)
      ..put('status', status)
      ..put('updatedAt', updatedAt);
  }

  TopicSubscribeItemModel.fromJson(Map<String, dynamic> json) {
    backgroundImg = json.asString('backgroundImg');
    classifyId = json.asInt('classifyId');
    createdAt = json.asString('createdAt');
    fakeLikeNum = json.asInt('fakeLikeNum');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    hot = json.asBool('hot');
    id = json.asString('id');
    introduction = json.asString('introduction');
    logo = json.asString('logo');
    name = json.asString('name');
    postNum = json.asInt('postNum');
    realLikeNum = json.asInt('realLikeNum');
    realWatchTimes = json.asInt('realWatchTimes');
    sortNum = json.asInt('sortNum');
    status = json.asBool('status');
    updatedAt = json.asString('updatedAt');
  }

  static TopicSubscribeItemModel toBean(Map<String, dynamic> json) =>
      TopicSubscribeItemModel.fromJson(json);
}
