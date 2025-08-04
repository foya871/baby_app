import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/community_content_model.dart';

class CommunityDateModel {
  int? dynamicId;
  int? dynamicType;
  int? dynamicMark;
  String? title;
  String? classifyName;
  double? price;
  int? userId;
  String? nickName;
  int? gender;
  int? vipType;
  bool? topDynamic;
  bool? isRecommend;
  int? status;
  String? notPass;
  String? checkAt;
  bool? attention;
  bool? isLike;
  bool? isFavorite;
  int? bu;
  int? fakeLikes;
  int? realLikes;
  int? fakeFavorites;
  int? realFavorites;
  int? fakeWatchTimes;
  int? realWatchTimes;
  int? commentNum;
  int? classifyType;
  List<String>? coverImg;
  List<CommunityContentModel>? contents;
  int? type;

  CommunityDateModel.add(String this.title, int this.type);

  CommunityDateModel({
    this.title,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('dynamicId', dynamicId)
      ..put('dynamicType', dynamicType)
      ..put('dynamicMark', dynamicMark)
      ..put('title', title)
      ..put('classifyName', classifyName)
      ..put('price', price)
      ..put('userId', userId)
      ..put('nickName', nickName)
      ..put('gender', gender)
      ..put('vipType', vipType)
      ..put('topDynamic', topDynamic)
      ..put('isRecommend', isRecommend)
      ..put('status', status)
      ..put('notPass', notPass)
      ..put('checkAt', checkAt)
      ..put('attention', attention)
      ..put('isLike', isLike)
      ..put('isFavorite', isFavorite)
      ..put('bu', bu)
      ..put('fakeLikes', fakeLikes)
      ..put('realLikes', realLikes)
      ..put('fakeFavorites', fakeFavorites)
      ..put('realFavorites', realFavorites)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('realWatchTimes', realWatchTimes)
      ..put('commentNum', commentNum)
      ..put('classifyType', classifyType)
      ..put('coverImg', coverImg)
      ..put('contents', contents);
  }

  CommunityDateModel.fromJson(Map<String, dynamic> json) {
    dynamicId = json.asInt('dynamicId');
    dynamicType = json.asInt('dynamicType');
    dynamicMark = json.asInt('dynamicMark');
    title = json.asString('title');
    classifyName = json.asString('classifyName');
    price = json.asDouble('price');
    userId = json.asInt('userId');
    nickName = json.asString('nickName');
    gender = json.asInt('gender');
    vipType = json.asInt('vipType');
    topDynamic = json.asBool('topDynamic');
    isRecommend = json.asBool('isRecommend');
    status = json.asInt('status');
    notPass = json.asString('notPass');
    checkAt = json.asString('checkAt');
    attention = json.asBool('attention');
    isLike = json.asBool('isLike');
    isFavorite = json.asBool('isFavorite');
    bu = json.asInt('bu');
    fakeLikes = json.asInt('fakeLikes');
    realLikes = json.asInt('realLikes');
    fakeFavorites = json.asInt('fakeFavorites');
    realFavorites = json.asInt('realFavorites');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    realWatchTimes = json.asInt('realWatchTimes');
    commentNum = json.asInt('commentNum');
    classifyType = json.asInt('classifyType');
    coverImg = json.asList<String>('coverImg') ?? [];
    contents = json.asList<CommunityContentModel>(
        'contents', CommunityContentModel.toBean);
    type = json.asInt('type');
  }

  static CommunityDateModel toBean(dynamic json) =>
      CommunityDateModel.fromJson(json);
}
