import 'dart:convert';

import 'package:flutter/foundation.dart';

class SendMessageModel {
  String? content;
  List<String>? imgs;
  int? quoteMsgId;
  int? toUserId;
  SendMessageModel({
    this.content,
    this.imgs,
    this.quoteMsgId,
    this.toUserId,
  });

  SendMessageModel copyWith({
    String? content,
    List<String>? imgs,
    int? quoteMsgId,
    int? toUserId,
  }) {
    return SendMessageModel(
      content: content ?? this.content,
      imgs: imgs ?? this.imgs,
      quoteMsgId: quoteMsgId ?? this.quoteMsgId,
      toUserId: toUserId ?? this.toUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'imgs': imgs,
      'quoteMsgId': quoteMsgId,
      'toUserId': toUserId,
    };
  }

  factory SendMessageModel.fromMap(Map<String, dynamic> map) {
    return SendMessageModel(
      content: map['content'] as String?,
      imgs: List<String>.from((map['imgs'] as List<String>?) ?? []),
      quoteMsgId: map['quoteMsgId']?.toInt(),
      toUserId: map['toUserId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageModel.fromJson(String source) =>
      SendMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendMessageModel(content: $content, imgs: $imgs, quoteMsgId: $quoteMsgId, toUserId: $toUserId)';
  }

  @override
  bool operator ==(covariant SendMessageModel other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        listEquals(other.imgs, imgs) &&
        other.quoteMsgId == quoteMsgId &&
        other.toUserId == toUserId;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        imgs.hashCode ^
        quoteMsgId.hashCode ^
        toUserId.hashCode;
  }
}
