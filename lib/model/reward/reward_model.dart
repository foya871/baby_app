import 'package:flutter/cupertino.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/utils/color.dart';

class RewardModel {
  String? id;
  String? rewardName;
  String? rewardTime;
  int? dailyBenefitNum;
  String? dailyBenefitName;
  List<CheckInGiftList>? checkinGiftList;
  List<CheckInGiftList>? giftList;
  int? status;
  int? whetherStatus;
  String? loge;
  String? dailyFitDesc;
  String? createdAt;
  String? updatedAt;

  RewardModel({
    id,
    rewardName,
    rewardTime,
    dailyBenefitNum,
    dailyBenefitName,
    checkinGiftList,
    giftList,
    status,
    whetherStatus,
    loge,
    dailyFitDesc,
    createdAt,
    updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('rewardName', rewardName)
      ..put('rewardTime', rewardTime)
      ..put('dailyBenefitNum', dailyBenefitNum)
      ..put('dailyBenefitName', dailyBenefitName)
      ..put('checkinGiftList', checkinGiftList?.map((v) => v.toJson()).toList())
      ..put('giftList', giftList?.map((v) => v.toJson()).toList())
      ..put('status', status)
      ..put('whetherStatus', whetherStatus)
      ..put('dailyFitDesc', dailyFitDesc)
      ..put('loge', loge)
      ..put('createdAt', createdAt)
      ..put('updatedAt', updatedAt);
  }

  RewardModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    rewardName = json.asString('rewardName');
    rewardTime = json.asString('rewardTime');
    dailyFitDesc = json.asString('dailyFitDesc');
    dailyBenefitNum = json.asInt('dailyBenefitNum');
    dailyBenefitName = json.asString('dailyBenefitName');
    checkinGiftList = json.asList<CheckInGiftList>('checkinGiftList',
        (v) => CheckInGiftList.fromJson(v as Map<String, dynamic>));
    giftList = json.asList<CheckInGiftList>(
        'giftList', (v) => CheckInGiftList.fromJson(v as Map<String, dynamic>));
    status = json.asInt('status');
    whetherStatus = json.asInt('whetherStatus');
    loge = json.asString('loge');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
  }

  static RewardModel toBean(Map<String, dynamic> json) =>
      RewardModel.fromJson(json);
}

class CheckInGiftList {
  int? type;
  String? giftId;
  int? giftNum;
  String? giftName;
  String? giftImg;

  CheckInGiftList({
    type,
    giftId,
    giftNum,
    giftName,
    giftImg,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('type', type)
      ..put('giftId', giftId)
      ..put('giftNum', giftNum)
      ..put('giftName', giftName)
      ..put('giftImg', giftImg);
  }

  CheckInGiftList.fromJson(Map<String, dynamic> json) {
    type = json.asInt('type');
    giftId = json.asString('giftId');
    giftNum = json.asInt('giftNum');
    giftName = json.asString('giftName');
    giftImg = json.asString('giftImg');
  }
}

extension RewardLogin on RewardModel {
  String get giftNumTrans {
    String result = "";
    if (giftList?.isNotEmpty == true) {
      result = giftList?[0].giftNum.toString() ?? "";
    }
    return result;
  }

  String get giftNumCheckInString {
    String result = "";
    if (checkinGiftList?.isNotEmpty == true) {
      var num = checkinGiftList?[0].giftNum;
      var name = checkinGiftList?[0].giftName;

      result = '$name+$num';
    }
    return result;
  }

  String get rightButtonText {
    return whetherStatus == 1 ? "已完成" : "去完成";
  }



  Color get rightButtonColor {
    return whetherStatus == 1 ? COLOR.white_20 : COLOR.color_009FE8;
  }

  Color get rightTextColor {
    return whetherStatus == 1 ? COLOR.white_80 : COLOR.white;
  }


  String get bottomDes {
    return isLocalApp ? "下载App获得奖励" : dailyFitDesc ?? "";
  }

  bool get isLocalApp {
    return dailyBenefitNum == 4;
  }
}
