import 'package:json2dart_safe/json2dart.dart';

import 'recharge_type_model.dart';

class GoldModel {
  String? name; //名称
  int? goldId; //金币商品id
  int? goldNum; //金币数量
  int? freeGoldNum; //赠送金币数量
  double? price; //金额
  String? desc; //描述
  List<RechargeTypeModel>? types;
  bool? isSelected;

  GoldModel(
      {this.name,
      this.goldId,
      this.goldNum,
      this.freeGoldNum,
      this.price,
      this.desc,
      this.types,
      this.isSelected});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('name', name)
      ..put('goldId', goldId)
      ..put('goldNum', goldNum)
      ..put('freeGoldNum', freeGoldNum)
      ..put('price', price)
      ..put('desc', desc)
      ..put('isSelected', isSelected)
      ..put('types', types?.map((v) => v.toJson()).toList());
  }

  GoldModel.fromJson(Map<String, dynamic> json) {
    name = json.asString('name');
    goldId = json.asInt('goldId');
    goldNum = json.asInt('goldNum');
    freeGoldNum = json.asInt('freeGoldNum');
    price = json.asDouble('price');
    desc = json.asString('desc');
    isSelected = json.asBool('isSelected');
    types = json.asList<RechargeTypeModel>('types', RechargeTypeModel.toBean);
  }

  static dynamic toBean(dynamic json) => GoldModel.fromJson(json);
}
