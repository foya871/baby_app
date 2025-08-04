import 'package:json2dart_safe/json2dart.dart';

class SameCityModel {
  int? meetUserId;
  String? nickName;
  String? logo;
  int? age;
  int? heightNum;
  String? bust;
  int? price;
  int? nightPrice;
  String? priceDel;
  List<String>? serviceTags;
  String? figure;
  List<BgImgs>? bgImgs;
  String? coverImg;
  int? unlockGold;
  String? cityName;
  String? info;
  int? lockNum;
  int? complaintNum;
  int? commentNum;
  String? reviewAt;
  bool? unlocked;
  String? createdAt;
  String? updatedAt;

  SameCityModel({
    meetUserId,
    nickName,
    logo,
    age,
    heightNum,
    bust,
    price,
    nightPrice,
    priceDel,
    serviceTags,
    figure,
    bgImgs,
    coverImg,
    unlockGold,
    cityName,
    info,
    lockNum,
    complaintNum,
    commentNum,
    reviewAt,
    unlocked,
    createdAt,
    updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('meetUserId', meetUserId)
      ..put('nickName', nickName)
      ..put('logo', logo)
      ..put('age', age)
      ..put('heightNum', heightNum)
      ..put('bust', bust)
      ..put('price', price)
      ..put('nightPrice', nightPrice)
      ..put('priceDel', priceDel)
      ..put('serviceTags', serviceTags)
      ..put('figure', figure)
      ..put('bgImgs', bgImgs?.map((v) => v.toJson()).toList())
      ..put('coverImg', coverImg)
      ..put('unlockGold', unlockGold)
      ..put('cityName', cityName)
      ..put('info', info)
      ..put('lockNum', lockNum)
      ..put('complaintNum', complaintNum)
      ..put('commentNum', commentNum)
      ..put('reviewAt', reviewAt)
      ..put('unlocked', unlocked)
      ..put('createdAt', createdAt)
      ..put('updatedAt', updatedAt);
  }

  SameCityModel.fromJson(Map<dynamic, dynamic> json) {
    meetUserId = json.asInt('meetUserId');
    nickName = json.asString('nickName');
    logo = json.asString('logo');
    age = json.asInt('age');
    heightNum = json.asInt('heightNum');
    bust = json.asString('bust');
    price = json.asInt('price');
    nightPrice = json.asInt('nightPrice');
    priceDel = json.asString('priceDel');
    serviceTags = json.asList<String>('serviceTags', null);
    figure = json.asString('figure');
    bgImgs = json.asList<BgImgs>('bgImgs', (v) => BgImgs.fromJson(v));
    coverImg = json.asString('coverImg');
    unlockGold = json.asInt('unlockGold');
    cityName = json.asString('cityName');
    info = json.asString('info');
    lockNum = json.asInt('lockNum');
    complaintNum = json.asInt('complaintNum');
    commentNum = json.asInt('commentNum');
    reviewAt = json.asString('reviewAt');
    unlocked = json.asBool('unlocked');
    createdAt = json.asString('createdAt');
    updatedAt = json.asString('updatedAt');
  }

  static SameCityModel toBean(Map<String, dynamic> json) =>
      SameCityModel.fromJson(json);
}

class BgImgs {
  String? fileId;
  int? type;
  String? url;
  String? coverImg;
  String? playTime;
  String? size;
  String? authKey;

  BgImgs({
    fileId,
    type,
    url,
    coverImg,
    playTime,
    size,
    authKey,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('fileId', fileId)
      ..put('type', type)
      ..put('url', url)
      ..put('coverImg', coverImg)
      ..put('playTime', playTime)
      ..put('size', size)
      ..put('authKey', authKey);
  }

  BgImgs.fromJson(Map<dynamic, dynamic> json) {
    fileId = json.asString('fileId');
    type = json.asInt('type');
    url = json.asString('url');
    coverImg = json.asString('coverImg');
    playTime = json.asString('playTime');
    size = json.asString('size');
    authKey = json.asString('authKey');
  }
}
