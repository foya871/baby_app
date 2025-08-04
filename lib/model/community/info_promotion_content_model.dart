import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/info_promotion_video_model.dart';

class InfoPromotionContentModel {
  List<String>? images; //图片
  String? text; //文本内容
  String? image; //图片
  int? type; //动态类型:0-普通 1-图片 2-推送视频、广告
  InfoPromotionVideoModel? infoVideo;
  int? infoId; //资讯id

  InfoPromotionContentModel.addText(int this.type, String this.text);

  InfoPromotionContentModel.addImage(int this.type, String this.image);

  InfoPromotionContentModel.addVideo(
      int this.type, InfoPromotionVideoModel this.infoVideo, this.infoId);

  InfoPromotionContentModel({
    this.images,
    this.text,
    this.type,
    this.infoVideo,
    this.infoId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('images', images)
      ..put('text', text)
      ..put('type', type)
      ..put('infoVideo', infoVideo)
      ..put('infoId', infoId);
  }

  InfoPromotionContentModel.fromJson(Map<String, dynamic> json) {
    images = json.asList<String>('images');
    text = json.asString('text');
    type = json.asInt('type');
    infoId = json.asInt('infoId');
    infoVideo = json.asBean('infoVideo',
        (v) => InfoPromotionVideoModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static InfoPromotionContentModel toBean(dynamic json) =>
      InfoPromotionContentModel.fromJson(json);
}
