import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/meet/meet_model.dart';
import 'package:baby_app/model/video_base_model.dart';

import '../community/community_model.dart';
import '../search/same_city_model.dart';

class WatchHistoryModel {
  List<VideoBaseModel>? videoList;
  List<CommunityModel>? dynamicList;
  List<SameCityModel>? meetUserList;
  String? domain;

  WatchHistoryModel({
    this.videoList,
    this.dynamicList,
    this.meetUserList,
    this.domain,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('videoList', this.videoList?.map((v) => v.toJson()).toList())
      ..put('dynamicList', this.dynamicList?.map((v) => v.toJson()).toList())
      ..put('meetUserList', this.meetUserList?.map((v) => v.toJson()).toList())
      ..put('domain', this.domain);
  }

  WatchHistoryModel.fromJson(Map<String, dynamic> json) {
    this.videoList = json.asList<VideoBaseModel>('videoList',
        (v) => VideoBaseModel.fromJson(Map<String, dynamic>.from(v)));
    this.dynamicList = json.asList<CommunityModel>('dynamicList',
        (v) => CommunityModel.fromJson(Map<String, dynamic>.from(v)));
    this.meetUserList = json.asList<SameCityModel>('meetUserList',
        (v) => SameCityModel.fromJson(Map<String, dynamic>.from(v)));
    this.domain = json.asString('domain');
  }

  static WatchHistoryModel toBean(Map<String, dynamic> json) =>
      WatchHistoryModel.fromJson(json);
}
