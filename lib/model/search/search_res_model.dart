/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-16 16:58:34
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-17 15:33:58
 * @FilePath: /baby_app/lib/model/search/search_res_model.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:baby_app/model/search/search_user_model.dart';
import 'package:baby_app/model/video_base_model.dart';

class SearchResModel {
  List<SearchUserModel>? userList;
  List<CommunityTopicModel>? topicList;
  String? domain;
  List<CommunityModel>? dynamicList;
  List<VideoBaseModel>? videoList;

  SearchResModel({
    this.userList,
    this.topicList,
    this.domain,
    this.dynamicList,
    this.videoList,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('userList', userList?.map((v) => v.toJson()).toList())
      ..put('topicList', topicList?.map((v) => v.toJson()).toList())
      ..put('domain', domain)
      ..put('dynamicList', dynamicList?.map((v) => v.toJson()).toList())
      ..put('videoList', videoList?.map((v) => v.toJson()).toList());
  }

  SearchResModel.fromJson(Map<String, dynamic> json) {
    userList = json.asList<SearchUserModel>('userList',
        (v) => SearchUserModel.fromJson(Map<String, dynamic>.from(v)));
    topicList = json.asList<CommunityTopicModel>('topicList',
        (v) => CommunityTopicModel.fromJson(Map<String, dynamic>.from(v)));
    domain = json.asString('domain');
    dynamicList = json.asList<CommunityModel>('dynamicList',
        (v) => CommunityModel.fromJson(Map<String, dynamic>.from(v)));
    videoList = json.asList<VideoBaseModel>('videoList',
        (v) => VideoBaseModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static SearchResModel toBean(Map<String, dynamic> json) =>
      SearchResModel.fromJson(json);
}

class CdnRes {
  String? id;
  String? line;
  int? mark;

  CdnRes({
    this.id,
    this.line,
    this.mark,
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

  static dynamic toBean(dynamic json) => CdnRes.fromJson(json);
}
