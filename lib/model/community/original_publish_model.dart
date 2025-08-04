import 'package:json2dart_safe/json2dart.dart';

class OriginalPublishModel {
  int? belongsId;
  String? belongsLogo;
  int? buyNum;
  CertVideo? certVideo;
  String? createdAt;
  String? id;
  List<String>? images;
  bool? isOrigin;
  int? price;
  int? productId;
  int? sortNum;
  int? status;
  int? sumIncome;
  String? title;
  String? updatedAt;
  String? buyAt;
  int? buyerId;
  String? buyerNickName;
  String? buyerLogo;
  String? tradeNo;
  bool? videoCert;

  OriginalPublishModel({
    this.belongsId,
    this.buyNum,
    this.certVideo,
    this.createdAt,
    this.id,
    this.images,
    this.isOrigin,
    this.price,
    this.productId,
    this.sortNum,
    this.status,
    this.sumIncome,
    this.title,
    this.updatedAt,
    this.buyAt,
    this.buyerId,
    this.buyerNickName,
    this.buyerLogo,
    this.tradeNo,
    this.videoCert,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('belongsId', this.belongsId)
      ..put('belongsLogo', this.belongsLogo)
      ..put('buyNum', this.buyNum)
      ..put('certVideo', this.certVideo?.toJson())
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('images', this.images)
      ..put('isOrigin', this.isOrigin)
      ..put('price', this.price)
      ..put('productId', this.productId)
      ..put('sortNum', this.sortNum)
      ..put('status', this.status)
      ..put('sumIncome', this.sumIncome)
      ..put('title', this.title)
      ..put('updatedAt', this.updatedAt)
      ..put('buyAt', this.buyAt)
      ..put('buyerId', this.buyerId)
      ..put('buyerNickName', this.buyerNickName)
      ..put('buyerLogo', this.buyerLogo)
      ..put('tradeNo', this.tradeNo)
      ..put('videoCert', this.videoCert);
  }

  OriginalPublishModel.fromJson(Map<String, dynamic> json) {
    this.belongsId = json.asInt('belongsId');
    this.belongsLogo = json.asString('belongsLogo');
    this.buyNum = json.asInt('buyNum');
    certVideo = json.asBean(
        'certVideo', (v) => CertVideo.fromJson(Map<String, dynamic>.from(v)));
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.images = json.asList<String>('images') ?? [];
    this.isOrigin = json.asBool('isOrigin');
    this.price = json.asInt('price');
    this.productId = json.asInt('productId');
    this.sortNum = json.asInt('sortNum');
    this.status = json.asInt('status');
    this.sumIncome = json.asInt('sumIncome');
    this.title = json.asString('title');
    this.updatedAt = json.asString('updatedAt');
    this.buyAt = json.asString('buyAt');
    this.buyerId = json.asInt('buyerId');
    this.buyerNickName = json.asString('buyerNickName');
    this.buyerLogo = json.asString('buyerLogo');
    this.tradeNo = json.asString('tradeNo');
    this.videoCert = json.asBool('videoCert');
  }

  static OriginalPublishModel toBean(Map<String, dynamic> json) =>
      OriginalPublishModel.fromJson(json);
}

class CertVideo {
  String? authKey;
  List<String>? coverImg;
  String? fileId;
  int? playTime;
  int? size;
  int? type;
  String? url;

  CertVideo({
    this.authKey,
    this.coverImg,
    this.fileId,
    this.playTime,
    this.size,
    this.type,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('authKey', this.authKey)
      ..put('coverImg', this.coverImg)
      ..put('fileId', this.fileId)
      ..put('playTime', this.playTime)
      ..put('size', this.size)
      ..put('type', this.type)
      ..put('url', this.url);
  }

  CertVideo.fromJson(Map<String, dynamic> json) {
    this.authKey = json.asString('authKey');
    this.coverImg = json.asList<String>('coverImg', null);
    this.fileId = json.asString('fileId');
    this.playTime = json.asInt('playTime');
    this.size = json.asInt('size');
    this.type = json.asInt('type');
    this.url = json.asString('url');
  }
}
