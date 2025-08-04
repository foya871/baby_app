import 'package:json2dart_safe/json2dart.dart';

class SystemNoticeModel {
  String? title;
  int? consumerUserId;
  String? content;
  String? createdAt;
  int? gold;
  int? informationType;
  String? msgActionDesc;
  int? producerIdentity;
  String? producerLogo;
  String? producerName;
  int? producerUserId;
  int? ticketType;
  String? updatedAt;

  SystemNoticeModel({
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
    this.ticketType,
    this.updatedAt,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('title', this.title)
      ..put('consumerUserId', this.consumerUserId)
      ..put('content', this.content)
      ..put('createdAt', this.createdAt)
      ..put('gold', this.gold)
      ..put('informationType', this.informationType)
      ..put('msgActionDesc', this.msgActionDesc)
      ..put('producerIdentity', this.producerIdentity)
      ..put('producerLogo', this.producerLogo)
      ..put('producerName', this.producerName)
      ..put('producerUserId', this.producerUserId)
      ..put('ticketType', this.ticketType)
      ..put('updatedAt', this.updatedAt);
  }

  SystemNoticeModel.fromJson(Map<String, dynamic> json) {
    this.consumerUserId = json.asInt('consumerUserId');
    this.content = json.asString('content');
    this.createdAt = json.asString('createdAt');
    this.gold = json.asInt('gold');
    this.informationType = json.asInt('informationType');
    this.msgActionDesc = json.asString('msgActionDesc');
    this.producerIdentity = json.asInt('producerIdentity');
    this.producerLogo = json.asString('producerLogo');
    this.producerName = json.asString('producerName');
    this.producerUserId = json.asInt('producerUserId');
    this.ticketType = json.asInt('ticketType');
    this.updatedAt = json.asString('updatedAt');
    this.title = json.asString('title');
  }

  static SystemNoticeModel toBean(Map<String, dynamic> json) =>
      SystemNoticeModel.fromJson(json);
}
