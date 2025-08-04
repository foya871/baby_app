import 'dart:convert';

class MessageNoticeModel {
  final int? consumerUserId;
  final String? content;
  final String? createdAt;
  final int? gold;
  final int? informationType;
  final String? msgActionDesc;
  final int? producerIdentity;
  final String? producerLogo;
  final String? producerName;
  final int? producerUserId;
  final QuoteMsg? quoteMsg;
  final int? ticketType;
  final String? updatedAt;
  MessageNoticeModel({
    this.consumerUserId,
    this.content,
    this.createdAt,
    this.gold,
    this.informationType,
    this.msgActionDesc,
    this.producerIdentity,
    this.producerLogo,
    this.producerName,
    this.producerUserId,
    this.quoteMsg,
    this.ticketType,
    this.updatedAt,
  });

  MessageNoticeModel copyWith({
    int? consumerUserId,
    String? content,
    String? createdAt,
    int? gold,
    int? informationType,
    String? msgActionDesc,
    int? producerIdentity,
    String? producerLogo,
    String? producerName,
    int? producerUserId,
    QuoteMsg? quoteMsg,
    int? ticketType,
    String? updatedAt,
  }) {
    return MessageNoticeModel(
      consumerUserId: consumerUserId ?? this.consumerUserId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      gold: gold ?? this.gold,
      informationType: informationType ?? this.informationType,
      msgActionDesc: msgActionDesc ?? this.msgActionDesc,
      producerIdentity: producerIdentity ?? this.producerIdentity,
      producerLogo: producerLogo ?? this.producerLogo,
      producerName: producerName ?? this.producerName,
      producerUserId: producerUserId ?? this.producerUserId,
      quoteMsg: quoteMsg ?? this.quoteMsg,
      ticketType: ticketType ?? this.ticketType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'consumerUserId': consumerUserId,
      'content': content,
      'createdAt': createdAt,
      'gold': gold,
      'informationType': informationType,
      'msgActionDesc': msgActionDesc,
      'producerIdentity': producerIdentity,
      'producerLogo': producerLogo,
      'producerName': producerName,
      'producerUserId': producerUserId,
      'quoteMsg': quoteMsg?.toMap(),
      'ticketType': ticketType,
      'updatedAt': updatedAt,
    };
  }

  factory MessageNoticeModel.fromMap(Map<String, dynamic> map) {
    return MessageNoticeModel(
      consumerUserId: map['consumerUserId']?.toInt() as int?,
      content: map['content'] as String?,
      createdAt: map['createdAt'] as String?,
      gold: map['gold']?.toInt() as int?,
      informationType: map['informationType']?.toInt() as int?,
      msgActionDesc: map['msgActionDesc'] as String?,
      producerIdentity: map['producerIdentity']?.toInt() as int?,
      producerLogo: map['producerLogo'] as String?,
      producerName: map['producerName'] as String?,
      producerUserId: map['producerUserId']?.toInt() as int?,
      quoteMsg: map['quoteMsg'] != null
          ? QuoteMsg.fromMap(map['quoteMsg'] as Map<String, dynamic>)
          : null,
      ticketType: map['ticketType']?.toInt() as int?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageNoticeModel.fromJson(String source) =>
      MessageNoticeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageNoticeModel(consumerUserId: $consumerUserId, content: $content, createdAt: $createdAt, gold: $gold, informationType: $informationType, msgActionDesc: $msgActionDesc, producerIdentity: $producerIdentity, producerLogo: $producerLogo, producerName: $producerName, producerUserId: $producerUserId, quoteMsg: $quoteMsg, ticketType: $ticketType, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant MessageNoticeModel other) {
    if (identical(this, other)) return true;

    return other.consumerUserId == consumerUserId &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.gold == gold &&
        other.informationType == informationType &&
        other.msgActionDesc == msgActionDesc &&
        other.producerIdentity == producerIdentity &&
        other.producerLogo == producerLogo &&
        other.producerName == producerName &&
        other.producerUserId == producerUserId &&
        other.quoteMsg == quoteMsg &&
        other.ticketType == ticketType &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return consumerUserId.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        gold.hashCode ^
        informationType.hashCode ^
        msgActionDesc.hashCode ^
        producerIdentity.hashCode ^
        producerLogo.hashCode ^
        producerName.hashCode ^
        producerUserId.hashCode ^
        quoteMsg.hashCode ^
        ticketType.hashCode ^
        updatedAt.hashCode;
  }
}

class QuoteMsg {
  final String? quoteSubContent;
  final int? quoteSubId;
  final String? quoteSubImg;
  final int? quoteSubImgType;
  final int? quoteSubLinkType;
  final int? quoteSubType;
  QuoteMsg({
    this.quoteSubContent,
    this.quoteSubId,
    this.quoteSubImg,
    this.quoteSubImgType,
    this.quoteSubLinkType,
    this.quoteSubType,
  });

  QuoteMsg copyWith({
    String? quoteSubContent,
    int? quoteSubId,
    String? quoteSubImg,
    int? quoteSubImgType,
    int? quoteSubLinkType,
    int? quoteSubType,
  }) {
    return QuoteMsg(
      quoteSubContent: quoteSubContent ?? this.quoteSubContent,
      quoteSubId: quoteSubId ?? this.quoteSubId,
      quoteSubImg: quoteSubImg ?? this.quoteSubImg,
      quoteSubImgType: quoteSubImgType ?? this.quoteSubImgType,
      quoteSubLinkType: quoteSubLinkType ?? this.quoteSubLinkType,
      quoteSubType: quoteSubType ?? this.quoteSubType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quoteSubContent': quoteSubContent,
      'quoteSubId': quoteSubId,
      'quoteSubImg': quoteSubImg,
      'quoteSubImgType': quoteSubImgType,
      'quoteSubLinkType': quoteSubLinkType,
      'quoteSubType': quoteSubType,
    };
  }

  factory QuoteMsg.fromMap(Map<String, dynamic> map) {
    return QuoteMsg(
      quoteSubContent: map['quoteSubContent'] as String?,
      quoteSubId: map['quoteSubId']?.toInt() as int?,
      quoteSubImg: map['quoteSubImg'] as String?,
      quoteSubImgType: map['quoteSubImgType']?.toInt() as int?,
      quoteSubLinkType: map['quoteSubLinkType']?.toInt() as int?,
      quoteSubType: map['quoteSubType']?.toInt() as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteMsg.fromJson(String source) =>
      QuoteMsg.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuoteMsg(quoteSubContent: $quoteSubContent, quoteSubId: $quoteSubId, quoteSubImg: $quoteSubImg, quoteSubImgType: $quoteSubImgType, quoteSubLinkType: $quoteSubLinkType, quoteSubType: $quoteSubType)';
  }

  @override
  bool operator ==(covariant QuoteMsg other) {
    if (identical(this, other)) return true;

    return other.quoteSubContent == quoteSubContent &&
        other.quoteSubId == quoteSubId &&
        other.quoteSubImg == quoteSubImg &&
        other.quoteSubImgType == quoteSubImgType &&
        other.quoteSubLinkType == quoteSubLinkType &&
        other.quoteSubType == quoteSubType;
  }

  @override
  int get hashCode {
    return quoteSubContent.hashCode ^
        quoteSubId.hashCode ^
        quoteSubImg.hashCode ^
        quoteSubImgType.hashCode ^
        quoteSubLinkType.hashCode ^
        quoteSubType.hashCode;
  }
}
