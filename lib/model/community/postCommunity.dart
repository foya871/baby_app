import 'package:json2dart_safe/json2dart.dart';

class PostCommunityParams {
  String? contentText;
  int? dynamicType;
  List<String>? images;
  int? price;
  String? title;
  String? topic;
  Video? video;

  PostCommunityParams({
    this.contentText,
    this.dynamicType,
    this.images,
    this.price,
    this.title,
    this.topic,
    this.video,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('contentText', this.contentText)
      ..put('dynamicType', this.dynamicType)
      ..put('images', this.images)
      ..put('price', this.price)
      ..put('title', this.title)
      ..put('topic', this.topic)
      ..put('video', this.video?.toJson());
  }

  PostCommunityParams.fromJson(Map<String, dynamic> json) {
    this.contentText = json.asString('contentText');
    this.dynamicType = json.asInt('dynamicType');
    this.images = json.asList<String>('images', null);
    this.price = json.asInt('price');
    this.title = json.asString('title');
    this.topic = json.asString('topic');
    this.video = json.asBean(
        'video', (v) => Video.fromJson(Map<String, dynamic>.from(v)));
  }

  static PostCommunityParams toBean(Map<String, dynamic> json) =>
      PostCommunityParams.fromJson(json);
}

class CdnRes {
  String? id;
  String? line;
  int? mark;
  bool? vip;

  CdnRes({
    this.id,
    this.line,
    this.mark,
    this.vip,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id', this.id)
      ..put('line', this.line)
      ..put('mark', this.mark)
      ..put('vip', this.vip);
  }

  CdnRes.fromJson(Map<String, dynamic> json) {
    this.id = json.asString('id');
    this.line = json.asString('line');
    this.mark = json.asInt('mark');
    this.vip = json.asBool('vip');
  }
}

class Video {
  String? id;
  int? playTime;
  String? title;
  String? videoUrl;

  Video({this.id, this.playTime, this.title, this.videoUrl});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id', this.id)
      ..put('playTime', this.playTime)
      ..put('title', this.title)
      ..put('videoUrl', this.videoUrl);
  }

  Video.fromJson(Map<String, dynamic> json) {
    this.id = json.asString('id');
    this.playTime = json.asInt('playTime');

    this.title = json.asString('title');
    this.videoUrl = json.asString('videoUrl');
  }
}
