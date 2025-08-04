import 'package:json2dart_safe/json2dart.dart';

import 'chat_model.dart';
import 'gold_model.dart';
import 'vip_model.dart';

class VipGoldTypeModel {
  List<VipModel>? vipCardList;
  List<GoldModel>? goldVipList;
  List<ChatModel>? chatVipCardList;

  VipGoldTypeModel({this.vipCardList, this.goldVipList, this.chatVipCardList});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('vipCardList', vipCardList?.map((v) => v.toJson()).toList())
      ..put('goldVipList', goldVipList?.map((v) => v.toJson()).toList())
      ..put(
          'chatVipCardList', chatVipCardList?.map((v) => v.toJson()).toList());
  }

  VipGoldTypeModel.fromJson(Map<String, dynamic> json) {
    vipCardList = json.asList<VipModel>(
        'vipCardList', (v) => VipModel.fromJson(Map<String, dynamic>.from(v)));
    goldVipList = json.asList<GoldModel>(
        'goldVipList', (v) => GoldModel.fromJson(Map<String, dynamic>.from(v)));
    chatVipCardList = json.asList<ChatModel>('chatVipCardList',
        (v) => ChatModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static VipGoldTypeModel toBean(Map<String, dynamic> json) {
    return VipGoldTypeModel.fromJson(json);
  }
}
