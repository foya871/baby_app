import 'package:json2dart_safe/json2dart.dart';

import '../utils/enum.dart';

class VideoContentModel {
  List<String> coverImg;
  String title;
  int videoId;
  VideoTypeEnum videoType;

  String get cover => coverImg.firstOrNull ?? '';

  VideoContentModel.fromJson(Map<String, dynamic> json)
      : coverImg = json.asList<String>('coverImg') ?? [],
        title = json.asString('title'),
        videoId = json.asInt('videoId'),
        videoType = json.asInt('videoType');

  static dynamic toBean(dynamic json) => VideoContentModel.fromJson(json);
}
