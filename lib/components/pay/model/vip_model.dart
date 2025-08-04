import 'package:json2dart_safe/json2dart.dart';

import 'recharge_type_model.dart';

class VipModel {
  int? cardId;
  String? cardName;
  String? cardImg;
  int? vipNumber;
  int? disPrice;
  int? price;
  String? remarks;
  String? cardRemarks;
  int? cardType;
  bool? isDeduct;
  bool? isNewUserDeduct;
  String? startDate;
  String? expiredDate;
  int? expiredTime;
  bool? isActivity;
  String? activityImg;
  String? activityImg1;
  List<RechargeTypeModel>? types;
  String? desc;
  bool? chatCard;

  VipModel({
    this.cardId,
    this.cardName,
    this.cardImg,
    this.vipNumber,
    this.disPrice,
    this.price,
    this.cardRemarks,
    this.desc,
    this.remarks,
    this.cardType,
    this.isDeduct,
    this.isNewUserDeduct,
    this.startDate,
    this.expiredDate,
    this.expiredTime,
    this.isActivity,
    this.activityImg,
    this.activityImg1,
    this.types,
    this.chatCard,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('cardId', cardId)
      ..put('cardName', cardName)
      ..put('cardRemarks', cardRemarks)
      ..put('cardImg', cardImg)
      ..put('vipNumber', vipNumber)
      ..put('disPrice', disPrice)
      ..put('price', price)
      ..put('remarks', remarks)
      ..put('cardType', cardType)
      ..put('isDeduct', isDeduct)
      ..put('isNewUserDeduct', isNewUserDeduct)
      ..put('startDate', startDate)
      ..put('expiredDate', expiredDate)
      ..put('expiredTime', expiredTime)
      ..put('isActivity', isActivity)
      ..put('activityImg', activityImg)
      ..put('activityImg1', activityImg1)
      ..put('desc', desc)
      ..put('types', types?.map((v) => v.toJson()).toList())
      ..put('chatCard', chatCard);
  }

  VipModel.fromJson(Map<String, dynamic> json) {
    cardId = json.asInt('cardId');
    cardName = json.asString('cardName');
    remarks = json.asString('remarks');
    cardImg = json.asString('cardImg');
    cardRemarks = json.asString('cardRemarks');
    vipNumber = json.asInt('vipNumber');
    disPrice = json.asInt('disPrice');
    price = json.asInt('price');
    cardType = json.asInt('cardType');
    isDeduct = json.asBool('isDeduct');
    isNewUserDeduct = json.asBool('isNewUserDeduct');
    startDate = json.asString('startDate');
    expiredDate = json.asString('expiredDate');
    expiredTime = json.asInt('expiredTime');
    isActivity = json.asBool('isActivity');
    activityImg = json.asString('activityImg');
    activityImg1 = json.asString('activityImg1');
    types = json.asList<RechargeTypeModel>('types',
        (v) => RechargeTypeModel.fromJson(Map<String, dynamic>.from(v)));
    desc = json.asString('desc');

    chatCard = json.asBool('chatCard');
  }

  static dynamic toBean(dynamic json) => VipModel.fromJson(json);
}

class RightsDesc {
  String? desc;
  String? title;
  String? logo;

  RightsDesc({
    this.desc,
    this.title,
    this.logo,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('desc', this.desc)
      ..put('logo', this.logo)
      ..put('title', this.title);
  }

  RightsDesc.fromJson(Map<String, dynamic> json) {
    this.desc = json.asString('desc');
    this.title = json.asString('title');
    this.logo = json.asString('logo');
  }
}
