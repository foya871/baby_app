import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:baby_app/model/community/community_video_model.dart';
import 'package:json2dart_safe/json2dart.dart';

class CommunityReleaseModel {
  int? dynamicType; //动态类型:1-图文 2-视频
  int? circleType; //动态帖子类型:0-社区动态 1-乱伦汇动态
  String? title; //动态标题
  String? contentText; //动态文本内容
  double? price; //价格
  List<String>? images; //图片
  List<String>? topics; //话题
  List<String>? topicNames; //话题
  CommunityVideoModel? video; //视频
  CommunityTopicModel? topic;

  CommunityReleaseModel({
    this.dynamicType,
    this.title,
    this.contentText,
    this.price,
    this.images,
    this.topics,
    this.topicNames,
    this.video,
    this.topic,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('dynamicType', dynamicType)
      ..put('circleType', circleType)
      ..put('title', title)
      ..put('contentText', contentText)
      ..put('price', price)
      ..put('images', images)
      ..put('topics', topics)
      ..put('topicNames', topicNames)
      ..put('topic', topic?.toJson())
      ..put('video', video?.toJson());
  }

  CommunityReleaseModel.fromJson(Map<String, dynamic> json) {
    dynamicType = json.asInt('dynamicType');
    circleType = json.asInt('circleType');
    title = json.asString('title');
    contentText = json.asString('contentText');
    price = json.asDouble('price');
    images = json.asList<String>('images');
    topics = json.asList<String>('topics');
    topicNames = json.asList<String>('topicNames');
    topic = json.asBean('topic',
        (v) => CommunityTopicModel.fromJson(Map<String, dynamic>.from(v)));
    video = json.asBean('video',
        (v) => CommunityVideoModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommunityReleaseModel toBean(dynamic json) =>
      CommunityReleaseModel.fromJson(json);
}
