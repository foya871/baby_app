import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/creator_model.dart';

class CommentDynamicModel {
  int? beUserId;
  String? beUserName;
  int? commentId;
  String? content;
  String? createdAt;
  int? fakeLikes;
  int? likes;
  int? gossipId;
  int? videoId;
  int? dynamicId;
  String? id;
  List<String>? img;
  bool? isLike;
  bool? jump;
  int? jumpType;
  String? jumpUrl;
  String? logo;
  String? nickName;
  bool? officialComment;
  int? parentId;
  int? replyNum;
  int? type;
  int? contentMark;
  int? userId;
  int? vipType;
  List<CommentDynamicModel>? comments;
  CreatorModel? creator;

  CommentDynamicModel({
    this.beUserId,
    this.beUserName,
    this.commentId,
    this.content,
    this.createdAt,
    this.fakeLikes,
    this.likes,
    this.gossipId,
    this.videoId,
    this.dynamicId,
    this.id,
    this.img,
    this.isLike,
    this.jump,
    this.jumpType,
    this.jumpUrl,
    this.logo,
    this.nickName,
    this.officialComment,
    this.parentId,
    this.replyNum,
    this.type,
    this.contentMark,
    this.userId,
    this.vipType,
    this.comments,
    this.creator,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('beUserId', this.beUserId)
      ..put('beUserName', this.beUserName)
      ..put('commentId', this.commentId)
      ..put('content', this.content)
      ..put('createdAt', this.createdAt)
      ..put('fakeLikes', this.fakeLikes)
      ..put('likes', this.likes)
      ..put('gossipId', this.gossipId)
      ..put('id', this.id)
      ..put('img', this.img)
      ..put('isLike', this.isLike)
      ..put('jump', this.jump)
      ..put('jumpType', this.jumpType)
      ..put('jumpUrl', this.jumpUrl)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('officialComment', this.officialComment)
      ..put('parentId', this.parentId)
      ..put('replyNum', this.replyNum)
      ..put('type', this.type)
      ..put('contentMark', this.contentMark)
      ..put('userId', this.userId)
      ..put('vipType', this.vipType)
      ..put('videoId', this.videoId)
      ..put('dynamicId', this.dynamicId)
      ..put('comments', this.comments)
      ..put('creator', this.creator);
  }

  CommentDynamicModel.fromJson(Map<String, dynamic> json) {
    this.beUserId = json.asInt('beUserId');
    this.beUserName = json.asString('beUserName');
    this.commentId = json.asInt('commentId');
    this.content = json.asString('content');
    this.createdAt = json.asString('createdAt');
    this.fakeLikes = json.asInt('fakeLikes');
    this.likes = json.asInt('likes');
    this.gossipId = json.asInt('gossipId');
    this.id = json.asString('id');
    this.img = json.asList<String>('img', null);
    this.isLike = json.asBool('isLike');
    this.jump = json.asBool('jump');
    this.jumpType = json.asInt('jumpType');
    this.jumpUrl = json.asString('jumpUrl');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.officialComment = json.asBool('officialComment');
    this.parentId = json.asInt('parentId');
    this.replyNum = json.asInt('replyNum');
    this.type = json.asInt('type');
    this.contentMark = json.asInt('contentMark');
    this.userId = json.asInt('userId');
    this.vipType = json.asInt('vipType');
    this.dynamicId = json.asInt('dynamicId');
    this.videoId = json.asInt('videoId');
    comments = json.asList<CommentDynamicModel>(
        'comments', CommentDynamicModel.toBean);
    creator = json.asBean(
        'creator', (v) => CreatorModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommentDynamicModel toBean(dynamic json) =>
      CommentDynamicModel.fromJson(json);
}
