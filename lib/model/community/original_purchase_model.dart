import 'package:json2dart_safe/json2dart.dart';

import 'original_publish_model.dart';

class OriginalPurchaseModel {
  String? address;
  int? belongsId;
  String? belongsLogo;
  String? buyAt;
  int? buyNum;
  int? buyerId;
  String? buyerLogo;
  String? buyerNickName;
  String? contactDetails;
  String? coverImg;
  String? createdAt;
  int? currencyType;
  String? detailAddress;
  String? endAt;
  String? id;
  bool? isArrived;
  bool? isUpShow;
  String? name;
  String? orderRemarkInfo;
  int? price;
  int? productId;
  String? productTitle;
  int? status;
  String? tradeNo;
  String? updatedAt;
  bool? isOrigin;
  CertVideo? certVideo;
  List<String>? images;

  OriginalPurchaseModel({
    this.address,
    this.belongsId,
    this.belongsLogo,
    this.buyAt,
    this.buyNum,
    this.buyerId,
    this.buyerLogo,
    this.buyerNickName,
    this.contactDetails,
    this.coverImg,
    this.createdAt,
    this.currencyType,
    this.detailAddress,
    this.endAt,
    this.id,
    this.isArrived,
    this.isUpShow,
    this.name,
    this.orderRemarkInfo,
    this.price,
    this.productId,
    this.productTitle,
    this.status,
    this.tradeNo,
    this.updatedAt,
    this.isOrigin,
    this.certVideo,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('address', this.address)
      ..put('belongsId', this.belongsId)
      ..put('belongsLogo', this.belongsLogo)
      ..put('buyAt', this.buyAt)
      ..put('buyNum', this.buyNum)
      ..put('buyerId', this.buyerId)
      ..put('buyerLogo', this.buyerLogo)
      ..put('buyerNickName', this.buyerNickName)
      ..put('contactDetails', this.contactDetails)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('currencyType', this.currencyType)
      ..put('detailAddress', this.detailAddress)
      ..put('endAt', this.endAt)
      ..put('images', this.images)
      ..put('id', this.id)
      ..put('isArrived', this.isArrived)
      ..put('isUpShow', this.isUpShow)
      ..put('name', this.name)
      ..put('orderRemarkInfo', this.orderRemarkInfo)
      ..put('price', this.price)
      ..put('productId', this.productId)
      ..put('productTitle', this.productTitle)
      ..put('status', this.status)
      ..put('tradeNo', this.tradeNo)
      ..put('updatedAt', this.updatedAt)
      ..put('certVideo', this.certVideo?.toJson())
      ..put('isOrigin', this.isOrigin);
  }

  OriginalPurchaseModel.fromJson(Map<String, dynamic> json) {
    this.address = json.asString('address');
    this.belongsId = json.asInt('belongsId');
    this.belongsLogo = json.asString('belongsLogo');
    this.buyAt = json.asString('buyAt');
    this.buyNum = json.asInt('buyNum');
    this.buyerId = json.asInt('buyerId');
    this.buyerLogo = json.asString('buyerLogo');
    this.buyerNickName = json.asString('buyerNickName');
    this.contactDetails = json.asString('contactDetails');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.currencyType = json.asInt('currencyType');
    this.detailAddress = json.asString('detailAddress');
    this.endAt = json.asString('endAt');
    this.id = json.asString('id');
    this.images = json.asList<String>('images') ?? [];
    this.isArrived = json.asBool('isArrived');
    this.isUpShow = json.asBool('isUpShow');
    this.name = json.asString('name');
    this.orderRemarkInfo = json.asString('orderRemarkInfo');
    this.price = json.asInt('price');
    this.productId = json.asInt('productId');
    this.productTitle = json.asString('productTitle');
    this.status = json.asInt('status');
    this.tradeNo = json.asString('tradeNo');
    this.updatedAt = json.asString('updatedAt');
    this.isOrigin = json.asBool('isOrigin');
    certVideo = json.asBean(
        'certVideo', (v) => CertVideo.fromJson(Map<String, dynamic>.from(v)));
  }

  static OriginalPurchaseModel toBean(Map<String, dynamic> json) =>
      OriginalPurchaseModel.fromJson(json);
}
