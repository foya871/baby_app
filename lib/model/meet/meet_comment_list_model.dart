import 'dart:convert';

import 'package:flutter/foundation.dart';

class MeetCommentListModel {
  final CommentUser? beUser;
  final int? commentId;
  final String? content;
  final String? createdAt;
  final CommentUser? creator;
  final String? img;
  final int? level;
  final int? medal;
  final int? meetUserId;
  final int? parentId;
  final int? replyNum;
  final int? type;
  final int? upLevel;
  List<MeetCommentListModel> commentList;

  MeetCommentListModel({
    this.beUser,
    this.commentId,
    this.content,
    this.createdAt,
    this.creator,
    this.img,
    this.level,
    this.medal,
    this.meetUserId,
    this.parentId,
    this.replyNum,
    this.type,
    this.upLevel,
    this.commentList = const [],
  });

  MeetCommentListModel copyWith({
    CommentUser? beUser,
    int? commentId,
    String? content,
    String? createdAt,
    CommentUser? creator,
    String? img,
    int? level,
    int? medal,
    int? meetUserId,
    int? parentId,
    int? replyNum,
    int? type,
    int? upLevel,
    List<MeetCommentListModel>? commentList,
  }) {
    return MeetCommentListModel(
      beUser: beUser ?? this.beUser,
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      img: img ?? this.img,
      level: level ?? this.level,
      medal: medal ?? this.medal,
      meetUserId: meetUserId ?? this.meetUserId,
      parentId: parentId ?? this.parentId,
      replyNum: replyNum ?? this.replyNum,
      type: type ?? this.type,
      upLevel: upLevel ?? this.upLevel,
      commentList: commentList ?? this.commentList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beUser': beUser?.toMap(),
      'commentId': commentId,
      'content': content,
      'createdAt': createdAt,
      'creator': creator?.toMap(),
      'img': img,
      'level': level,
      'medal': medal,
      'meetUserId': meetUserId,
      'parentId': parentId,
      'replyNum': replyNum,
      'type': type,
      'upLevel': upLevel,
      'commentList': commentList.map((x) => x.toMap()).toList(),
    };
  }

  factory MeetCommentListModel.fromMap(Map<String, dynamic> map) {
    return MeetCommentListModel(
      beUser: map['beUser'] != null
          ? CommentUser.fromMap(map['beUser'] as Map<String, dynamic>)
          : null,
      commentId: map['commentId'] != null ? map['commentId'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      creator: map['creator'] != null
          ? CommentUser.fromMap(map['creator'] as Map<String, dynamic>)
          : null,
      img: map['img'] != null ? map['img'] as String : null,
      level: map['level'] != null ? map['level'] as int : null,
      medal: map['medal'] != null ? map['medal'] as int : null,
      meetUserId: map['meetUserId'] != null ? map['meetUserId'] as int : null,
      parentId: map['parentId'] != null ? map['parentId'] as int : null,
      replyNum: map['replyNum'] != null ? map['replyNum'] as int : null,
      type: map['type'] != null ? map['type'] as int : null,
      upLevel: map['upLevel'] != null ? map['upLevel'] as int : null,
      commentList: map['commentList'] != null
          ? List<MeetCommentListModel>.from(
              (map['commentList'] as List<dynamic>).map(
                (x) => MeetCommentListModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetCommentListModel.fromJson(String source) =>
      MeetCommentListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MeetCommentListModel(beUser: $beUser, commentId: $commentId, content: $content, createdAt: $createdAt, creator: $creator, img: $img, level: $level, medal: $medal, meetUserId: $meetUserId, parentId: $parentId, replyNum: $replyNum, type: $type, upLevel: $upLevel, commentList: $commentList)';
  }

  @override
  bool operator ==(covariant MeetCommentListModel other) {
    if (identical(this, other)) return true;

    return other.beUser == beUser &&
        other.commentId == commentId &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.creator == creator &&
        other.img == img &&
        other.level == level &&
        other.medal == medal &&
        other.meetUserId == meetUserId &&
        other.parentId == parentId &&
        other.replyNum == replyNum &&
        other.type == type &&
        other.upLevel == upLevel &&
        listEquals(other.commentList, commentList);
  }

  @override
  int get hashCode {
    return beUser.hashCode ^
        commentId.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        creator.hashCode ^
        img.hashCode ^
        level.hashCode ^
        medal.hashCode ^
        meetUserId.hashCode ^
        parentId.hashCode ^
        replyNum.hashCode ^
        type.hashCode ^
        upLevel.hashCode ^
        commentList.hashCode;
  }
}

class CommentUser {
  final String? logo;
  final String? nickName;
  final int? userId;
  final int? vipType;

  CommentUser({
    this.logo,
    this.nickName,
    this.userId,
    this.vipType,
  });

  CommentUser copyWith({
    String? logo,
    String? nickName,
    int? userId,
    int? vipType,
  }) {
    return CommentUser(
      logo: logo ?? this.logo,
      nickName: nickName ?? this.nickName,
      userId: userId ?? this.userId,
      vipType: vipType ?? this.vipType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo': logo,
      'nickName': nickName,
      'userId': userId,
      'vipType': vipType,
    };
  }

  factory CommentUser.fromMap(Map<String, dynamic> map) {
    return CommentUser(
      logo: map['logo'] != null ? map['logo'] as String : null,
      nickName: map['nickName'] != null ? map['nickName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      vipType: map['vipType'] != null ? map['vipType'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentUser.fromJson(String source) =>
      CommentUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentUser(logo: $logo, nickName: $nickName, userId: $userId, vipType: $vipType)';
  }

  @override
  bool operator ==(covariant CommentUser other) {
    if (identical(this, other)) return true;

    return other.logo == logo &&
        other.nickName == nickName &&
        other.userId == userId &&
        other.vipType == vipType;
  }

  @override
  int get hashCode {
    return logo.hashCode ^
        nickName.hashCode ^
        userId.hashCode ^
        vipType.hashCode;
  }
}
