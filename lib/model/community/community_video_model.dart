import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/play/cdn_model.dart';

import '../../env/environment_service.dart';

class CommunityVideoModel {
  String? videoUrl;
  String? authKey;
  String? coverImg;
  int? height;
  int? width;
  String? id;
  int? playTime;
  String? resourceTitle;
  String? title;
  String? cdnId;
  CdnRsp? cdnRes;

  CommunityVideoModel({
    this.videoUrl,
    this.authKey,
    this.coverImg,
    this.height,
    this.width,
    this.id,
    this.playTime,
    this.resourceTitle,
    this.title,
    this.cdnId,
    this.cdnRes,
  });

  bool get isEmpty => id == null || id!.isEmpty;

  String get playPath => Environment.buildAuthPlayUrlString(
        videoUrl: videoUrl,
        authKey: authKey,
        id: cdnId,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('videoUrl', videoUrl)
      ..put('authKey', authKey)
      ..put('coverImg', coverImg)
      ..put('height', height)
      ..put('width', width)
      ..put('id', id)
      ..put('playTime', playTime)
      ..put('resourceTitle', resourceTitle)
      ..put('title', title)
      ..put('cdnId', cdnId)
      ..put('cdnRes', cdnRes);
  }

  CommunityVideoModel.fromJson(Map<String, dynamic> json) {
    videoUrl = json.asString('videoUrl');
    authKey = json.asString('authKey');
    coverImg = json.asString('coverImg');
    height = json.asInt('height');
    width = json.asInt('width');
    id = json.asString('id');
    playTime = json.asInt('playTime');
    resourceTitle = json.asString('resourceTitle');
    title = json.asString('title');
    cdnId = json.asString('cdnId');
    cdnRes = json.asBean(
        'cdnRes', (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommunityVideoModel toBean(dynamic json) =>
      CommunityVideoModel.fromJson(json);
}
