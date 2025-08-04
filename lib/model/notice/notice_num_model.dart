import 'package:json2dart_safe/json2dart.dart';

class NoticeNumModel {
  String? id;
  int? userId;
  int? sysNoticeNum;
  int? followedNoticedNum;
  int? commentNoticeNum;
  int? praisedNoticeNum;
  String? sysLastCleanTime;
  String? createdAt;
  String? updatedAt;

  NoticeNumModel({
    id,
    userId,
    sysNoticeNum,
    followedNoticedNum,
    commentNoticeNum,
    praisedNoticeNum,
    sysLastCleanTime,
    createdAt,
    updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('userId', userId)
      ..put('sysNoticeNum', sysNoticeNum)
      ..put('commentNoticeNum', commentNoticeNum)
      ..put('followedNoticedNum', followedNoticedNum)
      ..put('praisedNoticeNum', praisedNoticeNum)
      ..put('sysLastCleanTime', sysLastCleanTime)
      ..put('createdAt', createdAt)
      ..put('updatedAt', updatedAt);
  }

  NoticeNumModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    userId = json.asInt('userId');
    sysNoticeNum = json.asInt('sysNoticeNum');
    commentNoticeNum = json.asInt('commentNoticeNum');
    followedNoticedNum = json.asInt('followedNoticedNum');
    praisedNoticeNum = json.asInt('praisedNoticeNum');
    sysLastCleanTime = json.asString('sysLastCleanTime');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
  }

  static NoticeNumModel toBean(Map<String, dynamic> json) =>
      NoticeNumModel.fromJson(json);
}
