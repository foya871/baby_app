import 'package:json2dart_safe/json2dart.dart';

class CollectionDetailModel {
  final int collectionId;
  final String collectionName;
  final String coverImg;
  bool favorite;
  final String logo;
  final String nickName;
  final int userId;
  final int videoNum;

  bool get isEmpty => collectionId == 0;

  CollectionDetailModel.empty() : this.fromJson({});

  CollectionDetailModel.fromJson(Map<String, dynamic> json)
      : collectionId = json.asInt('collectionId'),
        collectionName = json.asString('collectionName'),
        coverImg = json.asString('coverImg'),
        favorite = json.asBool('favorite'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        userId = json.asInt('userId'),
        videoNum = json.asInt('videoNum');

  static dynamic toBean(dynamic json) => CollectionDetailModel.fromJson(json);
}
