import 'package:json2dart_safe/json2dart.dart';

import 'recharge_type_model.dart';

class ChatModel {
  int? cardId;
  String? cardName;
  String? cardImg;
  String? vipNumber;
  int? disPrice;
  int? price;
  String? desc;
  int? cardType;
  bool? isDeduct;
  bool? isNewUserDeduct;
  String? startDate;
  String? expiredDate;
  String? expiredTime;
  bool? isActivity;
  String? activityImg;
  List<RechargeTypeModel>? types;
  bool? chatCard;

  ChatModel(
      {this.cardId,
      this.cardName,
      this.cardImg,
      this.vipNumber,
      this.disPrice,
      this.price,
      this.desc,
      this.cardType,
      this.isDeduct,
      this.isNewUserDeduct,
      this.startDate,
      this.expiredDate,
      this.expiredTime,
      this.isActivity,
      this.activityImg,
      this.types,
      this.chatCard});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('cardId', cardId)
      ..put('cardName', cardName)
      ..put('cardImg', cardImg)
      ..put('vipNumber', vipNumber)
      ..put('disPrice', disPrice)
      ..put('price', price)
      ..put('desc', desc)
      ..put('cardType', cardType)
      ..put('isDeduct', isDeduct)
      ..put('isNewUserDeduct', isNewUserDeduct)
      ..put('startDate', startDate)
      ..put('expiredDate', expiredDate)
      ..put('expiredTime', expiredTime)
      ..put('isActivity', isActivity)
      ..put('activityImg', activityImg)
      ..put('types', types?.map((v) => v.toJson()).toList())
      ..put('chatCard', chatCard);
  }

  ChatModel.fromJson(Map<String, dynamic> json) {
    cardId = json.asInt('cardId');
    cardName = json.asString('cardName');
    cardImg = json.asString('cardImg');
    vipNumber = json.asString('vipNumber');
    disPrice = json.asInt('disPrice');
    price = json.asInt('price');
    desc = json.asString('desc');
    cardType = json.asInt('cardType');
    isDeduct = json.asBool('isDeduct');
    isNewUserDeduct = json.asBool('isNewUserDeduct');
    startDate = json.asString('startDate');
    expiredDate = json.asString('expiredDate');
    expiredTime = json.asString('expiredTime');
    isActivity = json.asBool('isActivity');
    activityImg = json.asString('activityImg');
    types = json.asList<RechargeTypeModel>('types',
        (v) => RechargeTypeModel.fromJson(Map<String, dynamic>.from(v)));
    chatCard = json.asBool('chatCard');
  }

  static ChatModel toBean(Map<String, dynamic> json) =>
      ChatModel.fromJson(json);
}
