/*
 * @Author: wangdazhuang
 * @Date: 2024-08-28 17:59:58
 * @LastEditTime: 2024-08-28 20:18:03
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/src/model/comment/comment_model.dart
 */
import 'package:get/get.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/services/user_service.dart';

import '../../components/ad/ad_info_model.dart';


class CommentModel {
  int beUserId;
  String beUserName;
  int commentId;
  String content;
  String createdAt;
  RxInt fakeLikes;
  String id;
  String img;
  RxBool isLike;
  bool jump;
  int jumpType;
  String jumpUrl;
  String logo;
  String nickName;
  bool officialComment;
  int parentId;
  int replyNum;
  int type;
  int userId;
  int videoId;
  int vipType;
  List<CommentModel>? replyItems;
  AdInfoModel? ad;

  CommentModel.empty() : this.fromJson({});

  CommentModel.fromJson(Map<String, dynamic> json)
      : beUserId = json.asInt('beUserId'),
        beUserName = json.asString('beUserName'),
        commentId = json.asInt('commentId'),
        content = json.asString('content'),
        createdAt = json.asString('createdAt'),
        fakeLikes = json.asInt('fakeLikes').obs,
        id = json.asString('id'),
        img = json.asString('img'),
        isLike = json.asBool('isLike').obs,
        jump = json.asBool('jump'),
        jumpType = json.asInt('jumpType'),
        jumpUrl = json.asString('jumpUrl'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        officialComment = json.asBool('officialComment'),
        parentId = json.asInt('parentId'),
        replyNum = json.asInt('replyNum'),
        type = json.asInt('type'),
        userId = json.asInt('userId'),
        videoId = json.asInt('videoId'),
        vipType = json.asInt('vipType'),
        replyItems = json.asList<CommentModel>(
          'replyItems',
          (v) => CommentModel.fromJson(Map<String, dynamic>.from(v)),
        );
  static toBean(Map<String, dynamic> json) => CommentModel.fromJson(json);
  bool get isAd => ad != null;

  static CommentModel fromAd(AdInfoModel model) {
    final value = CommentModel.fromJson({});
    value.ad = model;
    return value;
  }

  bool get isFake => commentId < 0;
  bool get hasParent => parentId == 0;

  static CommentModel makeFake(
    int videoId, {
    required String content,
    CommentModel? parent,
    CommentModel? child,
  }) {
    if (parent == null) {
      return makeFakeAfterReplyVideo(videoId, content: content);
    } else {
      if (child == null) {
        return makeFakeAfterReplyParent(
          videoId,
          parent: parent,
          content: content,
        );
      } else {
        return makeFakeAfterReplyChild(
          videoId,
          parent: parent,
          child: child,
          content: content,
        );
      }
    }
  }

  // 回复视频
  static CommentModel makeFakeAfterReplyVideo(int videoId,
      {required String content}) {
    final fake = CommentModel.empty();
    final user = Get.find<UserService>().user;
    final now = DateTime.now();
    fake.commentId = -1 * now.millisecondsSinceEpoch;
    fake.content = content;
    fake.createdAt = now.toString();
    fake.logo = user.logo ?? '';
    fake.nickName = user.nickName ?? '';
    fake.type = 1;
    fake.userId = user.userId ?? 0;
    fake.videoId = videoId;
    return fake;
  }

  // 回复主评论
  static CommentModel makeFakeAfterReplyParent(int videoId,
      {required CommentModel parent, required String content}) {
    final fake = makeFakeAfterReplyVideo(videoId, content: content);
    fake.beUserId = parent.userId;
    fake.beUserName = parent.nickName;
    fake.parentId = parent.commentId;
    fake.type = 2;

    parent.replyNum++;
    return fake;
  }

  // 回复子评论
  static CommentModel makeFakeAfterReplyChild(int videoId,
      {required CommentModel parent,
      required CommentModel child,
      required String content}) {
    final fake = makeFakeAfterReplyParent(
      videoId,
      parent: parent,
      content: content,
    );
    fake.beUserId = child.userId;
    fake.beUserName = child.nickName;

    child.replyNum++; // ?? 貌似没用!
    return fake;
  }
}
