/*
 * @Author: wdz
 * @Date: 2025-05-15 14:52:40
 * @LastEditTime: 2025-06-28 09:17:30
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/model/search/search_result_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/search/same_city_model.dart';
import 'package:baby_app/model/search/search_comic_model.dart';
import 'package:baby_app/model/search/search_post_model.dart';
import 'package:baby_app/model/search/search_topic_model.dart';
import 'package:baby_app/model/search/search_video_result_model.dart';

import '../community/community_model.dart';
import '../community/community_topic_model.dart';
import '../game/game_cell_model.dart';
import '../video_base_model.dart';

class SearchResultModel {
  List<VideoBaseModel>? videoList;
  List<CommunityModel>? dynamicList;

  List<SameCityModel>? meetUserList;
  List<CommunityTopicModel>? topicList;
  List<GameCellModel>? adultGameList;

  SearchResultModel({
    videoList,
    dynamicList,
    meetUserList,
    topicList,
    adultGameList,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('videoList', videoList?.map((v) => v.toJson()).toList())
      ..put('dynamicList', dynamicList?.map((v) => v.toJson()).toList())
      ..put('meetUserList', meetUserList?.map((v) => v.toJson()).toList())
      ..put('topicList', topicList?.map((v) => v.toJson()).toList())
      ..put('adultGameList', adultGameList?.map((v) => v.toJson()).toList());
  }

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    videoList = json.asList<VideoBaseModel>(
        'videoList', (v) => VideoBaseModel.fromJson(v as Map<String, dynamic>));
    dynamicList = json.asList<CommunityModel>('dynamicList',
        (v) => CommunityModel.fromJson(v as Map<String, dynamic>));
    meetUserList = json.asList<SameCityModel>('meetUserList',
        (v) => SameCityModel.fromJson(v as Map<String, dynamic>));
    topicList = json.asList<CommunityTopicModel>('topicList',
        (v) => CommunityTopicModel.fromJson(v as Map<String, dynamic>));
    adultGameList = json.asList<GameCellModel>('adultGameList',
        (v) => GameCellModel.fromJson(v as Map<String, dynamic>));
  }

  static SearchResultModel toBean(Map<String, dynamic> json) =>
      SearchResultModel.fromJson(json);
}
