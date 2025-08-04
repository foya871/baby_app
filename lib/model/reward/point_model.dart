import 'package:json2dart_safe/json2dart.dart';

class PointModel {
  String? id;
  int? redemptionType;
  String? giftId;
  String? redemptionName;
  int? redemptionIntegral;
  int? redemptionNum;
  String? bonusImage;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? desc;

  PointModel({
    id,
    redemptionType,
    giftId,
    redemptionName,
    redemptionIntegral,
    redemptionNum,
    bonusImage,
    status,
    createdAt,
    updatedAt,
    desc,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('redemptionType', redemptionType)
      ..put('giftId', giftId)
      ..put('redemptionName', redemptionName)
      ..put('redemptionIntegral', redemptionIntegral)
      ..put('redemptionNum', redemptionNum)
      ..put('bonusImage', bonusImage)
      ..put('status', status)
      ..put('createdAt', createdAt)
      ..put('desc', desc)
      ..put('updatedAt', updatedAt);
  }

  PointModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    redemptionType = json.asInt('redemptionType');
    giftId = json.asString('giftId');
    redemptionName = json.asString('redemptionName');
    redemptionIntegral = json.asInt('redemptionIntegral');
    redemptionNum = json.asInt('redemptionNum');
    bonusImage = json.asString('bonusImage');
    status = json.asInt('status');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
    desc = json.asString('desc');
  }

  static PointModel toBean(Map<String, dynamic> json) =>
      PointModel.fromJson(json);
}
