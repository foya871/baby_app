import 'package:json2dart_safe/json2dart.dart';

class InfoPromotionVideoModel {
  String? head; //标头
  int? targetId; //目标id
  String? title; //标题
  int? type; //1-视频 2-漫画 3-广告
  int? jumpType; //跳转类型：1、内部跳转 2、外部跳转
  String? jumpUrl; //跳转地址

  InfoPromotionVideoModel({
    this.head,
    this.targetId,
    this.title,
    this.type,
    this.jumpType,
    this.jumpUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('head', head)
      ..put('targetId', targetId)
      ..put('title', title)
      ..put('type', type)
      ..put('jumpType', jumpType)
      ..put('jumpUrl', jumpUrl);
  }

  InfoPromotionVideoModel.fromJson(Map<String, dynamic> json) {
    head = json.asString('head');
    targetId = json.asInt('targetId');
    title = json.asString('title');
    type = json.asInt('type');
    jumpType = json.asInt('jumpType');
    jumpUrl = json.asString('jumpUrl');
  }

  static InfoPromotionVideoModel toBean(dynamic json) =>
      InfoPromotionVideoModel.fromJson(json);
}
