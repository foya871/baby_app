import 'package:json2dart_safe/json2dart.dart';

import 'video_actress_model.dart';

class PornographyModel {
  int contentId;
  String contentName;
  String headImg;

  PornographyModel.fromJson(Map<String, dynamic> json)
      : contentId = json.asInt('contentId'),
        contentName = json.asString('contentName'),
        headImg = json.asString('headImg');

  static dynamic toBean(dynamic json) => PornographyModel.fromJson(json);
}

class ContentBaseModel {
  final int contentId;
  final String contentName;
  final int fakeBuNum;
  final int fakePlayNum;
  final String headImg;
  final String info;
  final int videoNum;
  List<VideoContentModel> videos;

  ContentBaseModel.fromJson(Map<String, dynamic> json)
      : contentId = json.asInt('contentId'),
        contentName = json.asString('contentName'),
        fakeBuNum = json.asInt('fakeBuNum'),
        fakePlayNum = json.asInt('fakePlayNum'),
        headImg = json.asString('headImg'),
        info = json.asString('info'),
        videoNum = json.asInt('videoNum'),
        videos = json.asList<VideoContentModel>(
                'videos', VideoContentModel.toBean) ??
            [];

  static dynamic toBean(dynamic json) => ContentBaseModel.fromJson(json);
}

class ContentHotModel {
  final int contentId;
  final String contentName;
  final int fakeBuNum;
  final String headImg;
  final String info;
  final int videoNum;

  ContentHotModel.fromJson(Map<String, dynamic> json)
      : contentId = json.asInt('contentId'),
        contentName = json.asString('contentName'),
        fakeBuNum = json.asInt('fakeBuNum'),
        headImg = json.asString('headImg'),
        info = json.asString('info'),
        videoNum = json.asInt('videoNum');

  static dynamic toBean(dynamic json) => ContentHotModel.fromJson(json);
}

class ContentDetailModel extends ContentBaseModel {
  bool isAttention;
  final String selfImg;

  ContentDetailModel.empty() : this.fromJson({});

  ContentDetailModel.fromJson(super.json)
      : isAttention = json.asBool('isAttention'),
        selfImg = json.asString('selfImg'),
        super.fromJson();
}

// 网黄Classify
class PornographyListResp {
  final List<PornographyModel> contentList;
  final List<ContentBaseModel> contentVideoList;

  PornographyListResp.fromJson(Map<String, dynamic> json)
      : contentList = json.asList('contentList', PornographyModel.toBean) ?? [],
        contentVideoList =
            json.asList('contentVideoList', ContentBaseModel.toBean) ?? [];
}

// 前端构造
class ContentActressPortraitBlockModel {
  final String title;
  List<PornographyModel> portraitList;

  ContentActressPortraitBlockModel({
    required this.title,
    required this.portraitList,
  });
}

// 前端构造
enum ContentActressStationType { video, portraitBlock }

// 前端构造
class ContentActressStationModel {
  final ContentBaseModel? content;
  final ContentActressPortraitBlockModel? portraitBlock;
  final ContentActressStationType type;
  ContentActressStationModel(this.type, {this.content, this.portraitBlock});
}
