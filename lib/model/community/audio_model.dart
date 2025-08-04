/*
 * @Author: wangdazhuang
 * @Date: 2025-01-21 15:49:25
 * @LastEditTime: 2025-01-21 15:50:46
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/model/community/audio_model.dart
 */

import 'package:json2dart_safe/json2dart.dart';

class AudioModel {
  String? audioUrl;
  CdnRes? cdnRes;
  String? coverImg;
  String? id;
  int? playTime;
  String? title;

  AudioModel({
    audioUrl,
    cdnRes,
    coverImg,
    id,
    playTime,
    title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('audioUrl', audioUrl)
      ..put('cdnRes', cdnRes?.toJson())
      ..put('coverImg', coverImg)
      ..put('id', id)
      ..put('playTime', playTime)
      ..put('title', title);
  }

  AudioModel.fromJson(Map<String, dynamic> json) {
    audioUrl = json.asString('audioUrl');
    cdnRes = json.asBean(
        'cdnRes', (v) => CdnRes.fromJson(Map<String, dynamic>.from(v)));
    coverImg = json.asString('coverImg');
    id = json.asString('id');
    playTime = json.asInt('playTime');
    title = json.asString('title');
  }

  static AudioModel toBean(Map<String, dynamic> json) =>
      AudioModel.fromJson(json);
}

class CdnRes {
  String? id;
  String? line;
  int? mark;

  CdnRes({
    id,
    line,
    mark,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('line', line)
      ..put('mark', mark);
  }

  CdnRes.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    line = json.asString('line');
    mark = json.asInt('mark');
  }
}
