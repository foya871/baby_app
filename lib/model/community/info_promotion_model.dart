import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/info_promotion_content_model.dart';

class InfoPromotionModel {
  bool? attention; //是否关注
  int? commentNum; //评论数
  String? coverImg; //封面
  int? fakeFavorites; //伪造收藏次数
  int? fakeWatchTimes; //伪造浏览次数
  int? fakeLikes; //伪造点赞次数
  bool? favorite; //是否收藏
  int? iconFlag; //标识 1-NEW
  int? infoId; //资讯id
  bool? like; //是否点赞
  String? logo; //头像
  String? nickName; //用户昵称
  String? title; //资讯标题
  int? userId; //发布者ID
  int? infoMark; //0-免费，1-vip，2-付费
  double? price; //价格
  String? checkAt; //审核时间
  bool? canWatch; //是否能看
  int? reasonType; //不能看原因：1-vip 2-付费
  List<InfoPromotionContentModel>? contents; //内容

  InfoPromotionModel({
    this.attention,
    this.commentNum,
    this.coverImg,
    this.fakeFavorites,
    this.fakeWatchTimes,
    this.fakeLikes,
    this.favorite,
    this.iconFlag,
    this.infoId,
    this.like,
    this.logo,
    this.nickName,
    this.title,
    this.userId,
    this.infoMark,
    this.price,
    this.checkAt,
    this.canWatch,
    this.reasonType,
    this.contents,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('attention', attention)
      ..put('commentNum', commentNum)
      ..put('coverImg', coverImg)
      ..put('fakeFavorites', fakeFavorites)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('fakeLikes', fakeLikes)
      ..put('favorite', favorite)
      ..put('iconFlag', iconFlag)
      ..put('infoId', infoId)
      ..put('like', like)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('title', title)
      ..put('userId', userId)
      ..put('infoMark', infoMark)
      ..put('price', price)
      ..put('checkAt', checkAt)
      ..put('canWatch', canWatch)
      ..put('reasonType', reasonType)
      ..put('contents', contents)
      ..put('contents', contents?.map((v) => v.toJson()).toList());
  }

  InfoPromotionModel.fromJson(Map<String, dynamic> json) {
    attention = json.asBool('attention');
    commentNum = json.asInt('commentNum');
    coverImg = json.asString('coverImg');
    fakeFavorites = json.asInt('fakeFavorites');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    fakeLikes = json.asInt('fakeLikes');
    favorite = json.asBool('favorite');
    iconFlag = json.asInt('iconFlag');
    infoId = json.asInt('infoId');
    like = json.asBool('like');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    title = json.asString('title');
    userId = json.asInt('userId');
    infoMark = json.asInt('infoMark');
    price = json.asDouble('price');
    checkAt = json.asString('checkAt');
    canWatch = json.asBool('canWatch');
    reasonType = json.asInt('reasonType');
    contents = json.asList<InfoPromotionContentModel>(
        'contents', InfoPromotionContentModel.toBean);
  }

  static InfoPromotionModel toBean(dynamic json) =>
      InfoPromotionModel.fromJson(json);
}
