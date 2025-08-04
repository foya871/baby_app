import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel {
  final String? content;
  final String? createdAt;
  final List<String>? imgs;
  final int? msgId;
  final int? msgType;
  final Quote? quote;
  final String? sendLogo;
  final String? sendNickName;
  final int? sendUserId;
  final int? vipType;
  MessageModel({
    this.content,
    this.createdAt,
    this.imgs,
    this.msgId,
    this.msgType,
    this.quote,
    this.sendLogo,
    this.sendNickName,
    this.sendUserId,
    this.vipType,
  });

  MessageModel copyWith({
    String? content,
    String? createdAt,
    List<String>? imgs,
    int? msgId,
    int? msgType,
    Quote? quote,
    String? sendLogo,
    String? sendNickName,
    int? sendUserId,
    int? vipType,
  }) {
    return MessageModel(
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      imgs: imgs ?? this.imgs,
      msgId: msgId ?? this.msgId,
      msgType: msgType ?? this.msgType,
      quote: quote ?? this.quote,
      sendLogo: sendLogo ?? this.sendLogo,
      sendNickName: sendNickName ?? this.sendNickName,
      sendUserId: sendUserId ?? this.sendUserId,
      vipType: vipType ?? this.vipType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'createdAt': createdAt,
      'imgs': imgs,
      'msgId': msgId,
      'msgType': msgType,
      'quote': quote?.toMap(),
      'sendLogo': sendLogo,
      'sendNickName': sendNickName,
      'sendUserId': sendUserId,
      'vipType': vipType,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      content: map['content'] as String?,
      createdAt: map['createdAt'] as String?,
      imgs: map['imgs'] != null
          ? List<String>.from((map['imgs'] as List<dynamic>))
          : null,
      msgId: map['msgId']?.toInt() as int?,
      msgType: map['msgType']?.toInt() as int?,
      quote: map['quote'] != null
          ? Quote.fromMap(map['quote'] as Map<String, dynamic>)
          : null,
      sendLogo: map['sendLogo'] as String?,
      sendNickName: map['sendNickName'] as String?,
      sendUserId: map['sendUserId']?.toInt() as int?,
      vipType: map['vipType']?.toInt() as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(content: $content, createdAt: $createdAt, imgs: $imgs, msgId: $msgId, msgType: $msgType, quote: $quote, sendLogo: $sendLogo, sendNickName: $sendNickName, sendUserId: $sendUserId, vipType: $vipType)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.createdAt == createdAt &&
        listEquals(other.imgs, imgs) &&
        other.msgId == msgId &&
        other.msgType == msgType &&
        other.quote == quote &&
        other.sendLogo == sendLogo &&
        other.sendNickName == sendNickName &&
        other.sendUserId == sendUserId &&
        other.vipType == vipType;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        createdAt.hashCode ^
        imgs.hashCode ^
        msgId.hashCode ^
        msgType.hashCode ^
        quote.hashCode ^
        sendLogo.hashCode ^
        sendNickName.hashCode ^
        sendUserId.hashCode ^
        vipType.hashCode;
  }
}

class Quote {
  final String? content;
  final List<String>? imgs;
  final int? msgType;
  final String? sendNickName;
  final int? sendUserId;
  Quote({
    this.content,
    this.imgs,
    this.msgType,
    this.sendNickName,
    this.sendUserId,
  });

  Quote copyWith({
    String? content,
    List<String>? imgs,
    int? msgType,
    String? sendNickName,
    int? sendUserId,
  }) {
    return Quote(
      content: content ?? this.content,
      imgs: imgs ?? this.imgs,
      msgType: msgType ?? this.msgType,
      sendNickName: sendNickName ?? this.sendNickName,
      sendUserId: sendUserId ?? this.sendUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'imgs': imgs,
      'msgType': msgType,
      'sendNickName': sendNickName,
      'sendUserId': sendUserId,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      content: map['content'] as String?,
      imgs: map['imgs'] != null
          ? List<String>.from((map['imgs'] as List<dynamic>))
          : null,
      msgType: map['msgType']?.toInt() as int?,
      sendNickName: map['sendNickName'] as String?,
      sendUserId: map['sendUserId']?.toInt() as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Quote(content: $content, imgs: $imgs, msgType: $msgType, sendNickName: $sendNickName, sendUserId: $sendUserId)';
  }

  @override
  bool operator ==(covariant Quote other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        listEquals(other.imgs, imgs) &&
        other.msgType == msgType &&
        other.sendNickName == sendNickName &&
        other.sendUserId == sendUserId;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        imgs.hashCode ^
        msgType.hashCode ^
        sendNickName.hashCode ^
        sendUserId.hashCode;
  }
}
