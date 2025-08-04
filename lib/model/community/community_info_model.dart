import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/community_video_model.dart';

class CommunityInfoModel {
  int? type; //0-普通 1-图片 2-视频
  String? text;
  String? image;
  List<String>? images;
  CommunityVideoModel? video;

  CommunityInfoModel.addText(int this.type, String this.text);

  CommunityInfoModel.addImage(int this.type, String this.image);

  CommunityInfoModel.addVideo(int this.type, CommunityVideoModel this.video);

  bool get isVideo => type == 2 && video != null && !video!.isEmpty;

  CommunityInfoModel({
    this.type,
    this.text,
    this.image,
    this.images,
    this.video,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('type', type)
      ..put('text', text)
      ..put('image', image)
      ..put('images', images)
      ..put('video', video);
  }

  CommunityInfoModel.fromJson(Map<String, dynamic> json) {
    type = json.asInt('type');
    text = json.asString('text');
    image = json.asString('image');
    images = json.asList<String>('images');
    video = json.asBean('video',
        (v) => CommunityVideoModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommunityInfoModel toBean(dynamic json) =>
      CommunityInfoModel.fromJson(json);
}
