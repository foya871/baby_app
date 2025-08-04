import 'package:json2dart_safe/json2dart.dart';

class NoticeModel {
  String? title;
  String? content;
  String? producerLogo;
  String? producerName;
  int? producerUserId;
  int? consumerUserId;
  int? informationType;
  String? msgActionDesc;
  QuoteMsgModel? quoteMsg;
  String? commentId;
  bool? isLike;
  bool? isAttention;
  int? likeNum;
  int? commentNum;
  String? cityName;
  String? createdAt;
  int? gender; //1-女,2-男,3-保密
  int? age;

  NoticeModel({
    this.title,
    this.content,
    this.producerLogo,
    this.producerName,
    this.producerUserId,
    this.consumerUserId,
    this.informationType,
    this.msgActionDesc,
    this.quoteMsg,
    this.commentId,
    this.isLike,
    this.isAttention,
    this.likeNum,
    this.commentNum,
    this.cityName,
    this.createdAt,
    this.gender,
    this.age,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('title', this.title)
      ..put('content', this.content)
      ..put('producerLogo', this.producerLogo)
      ..put('producerName', this.producerName)
      ..put('producerUserId', this.producerUserId)
      ..put('consumerUserId', this.consumerUserId)
      ..put('informationType', this.informationType)
      ..put('msgActionDesc', this.msgActionDesc)
      ..put('quoteMsg', this.quoteMsg)
      ..put('commentId', this.commentId)
      ..put('isLike', this.isLike)
      ..put('isAttention', this.isAttention)
      ..put('likeNum', this.likeNum)
      ..put('commentNum', this.commentNum)
      ..put('cityName', this.cityName)
      ..put('createdAt', this.createdAt)
      ..put('gender', this.gender)
      ..put('age', this.age);
  }

  NoticeModel.fromJson(Map<String, dynamic> json) {
    this.title = json.asString('title');
    this.content = json.asString('content');
    this.producerLogo = json.asString('producerLogo');
    this.producerName = json.asString('producerName');
    this.producerUserId = json.asInt('producerUserId');
    this.consumerUserId = json.asInt('consumerUserId');
    this.informationType = json.asInt('informationType');
    this.msgActionDesc = json.asString('msgActionDesc');
    quoteMsg = json.asBean("quoteMsg",
        (v) => QuoteMsgModel.fromJson(Map<String, dynamic>.from(v)));
    this.commentId = json.asString('commentId');
    this.isLike = json.asBool('isLike');
    this.isAttention = json.asBool('isAttention');
    this.likeNum = json.asInt('likeNum');
    this.commentNum = json.asInt('commentNum');
    this.cityName = json.asString('cityName');
    this.createdAt = json.asString('createdAt');
    this.gender = json.asInt('gender');
    this.age = json.asInt('age');
  }

  static NoticeModel toBean(Map<String, dynamic> json) =>
      NoticeModel.fromJson(json);

  NoticeModel copyWith({
    String? title,
    String? content,
    String? producerLogo,
    String? producerName,
    int? producerUserId,
    int? consumerUserId,
    int? informationType,
    String? msgActionDesc,
    QuoteMsgModel? quoteMsg,
    String? commentId,
    bool? isLike,
    bool? isAttention,
    int? likeNum,
    int? commentNum,
    String? cityName,
    String? createdAt,
    int? gender,
    int? age,
  }) {
    return NoticeModel(
      title: title ?? this.title,
      content: content ?? this.content,
      producerLogo: producerLogo ?? this.producerLogo,
      producerName: producerName ?? this.producerName,
      producerUserId: producerUserId ?? this.producerUserId,
      consumerUserId: consumerUserId ?? this.consumerUserId,
      informationType: informationType ?? this.informationType,
      msgActionDesc: msgActionDesc ?? this.msgActionDesc,
      quoteMsg: quoteMsg ?? this.quoteMsg,
      commentId: commentId ?? this.commentId,
      isLike: isLike ?? this.isLike,
      isAttention: isAttention ?? this.isAttention,
      likeNum: likeNum ?? this.likeNum,
      commentNum: commentNum ?? this.commentNum,
      cityName: cityName ?? this.cityName,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }
}

class QuoteMsgModel {
  String? quoteSubContent;
  int? quoteSubId;
  String? quoteSubImg;
  int? quoteSubImgType;
  int? quoteSubLinkType;
  int? quoteSubType;

  QuoteMsgModel({
    this.quoteSubContent,
    this.quoteSubId,
    this.quoteSubImg,
    this.quoteSubImgType,
    this.quoteSubLinkType,
    this.quoteSubType,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('quoteSubContent', this.quoteSubContent)
      ..put('quoteSubId', this.quoteSubId)
      ..put('quoteSubImg', this.quoteSubImg)
      ..put('quoteSubImgType', this.quoteSubImgType)
      ..put('quoteSubLinkType', this.quoteSubLinkType)
      ..put('quoteSubType', this.quoteSubType);
  }

  QuoteMsgModel.fromJson(Map<String, dynamic> json) {
    this.quoteSubContent = json.asString('quoteSubContent');
    this.quoteSubId = json.asInt('quoteSubId');
    this.quoteSubImg = json.asString('quoteSubImg');
    this.quoteSubImgType = json.asInt('quoteSubImgType');
    this.quoteSubLinkType = json.asInt('quoteSubLinkType');
    this.quoteSubType = json.asInt('quoteSubType');
  }
}
