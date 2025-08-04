/*
 * @Author: wangdazhuang
 * @Date: 2024-12-11 16:57:07
 * @LastEditTime: 2025-01-21 16:00:59
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/model/community/community_content_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/community_video_model.dart';

import 'audio_model.dart';

class CommunityContentModel {
  List<String>? images; //图片
  String? text; //文本内容
  String? image; //图片
  int? type; //动态类型:0-普通 1-图片 2-视频 3-音频
  CommunityVideoModel? video;
  String? identifier;
  AudioModel? audio;

  CommunityContentModel.addText(
      int this.type, String this.text, this.identifier);

  CommunityContentModel.addImage(int this.type, String this.image);

  CommunityContentModel.addImages(
      int this.type, List<String> this.images, this.identifier);

  CommunityContentModel.addVideo(int this.type, CommunityVideoModel this.video);

  CommunityContentModel({
    this.images,
    this.text,
    this.type,
    this.video,
    this.identifier,
    this.audio,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('images', images)
      ..put('text', text)
      ..put('type', type)
      ..put('identifier', identifier)
      ..put('audio', audio)
      ..put('video', video);
  }

  CommunityContentModel.fromJson(Map<String, dynamic> json) {
    images = json.asList<String>('images');
    text = json.asString('text');
    type = json.asInt('type');
    video = json.asBean('video',
        (v) => CommunityVideoModel.fromJson(Map<String, dynamic>.from(v)));
    audio = json.asBean(
        'audio', (v) => AudioModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommunityContentModel toBean(dynamic json) =>
      CommunityContentModel.fromJson(json);
}
