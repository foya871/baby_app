import 'package:json2dart_safe/json2dart.dart';

class VideoInfoModel {
  String? id;
  String? previewId;
  int? videoId;
  String? title;
  String? videoUrl;
  String? previewUrl;
  String? coverImg;
  String? verticalImg;
  int? playTime;
  int? size;
  int? height;
  int? width;
  List<String>? searchTitle;
  List<String>? completeSplit;
  List<String>? classify;
  List<String>? tags;
  int? likes;
  int? realLikes;
  int? favorites;
  int? realFavorites;
  int? watchNum;
  int? realWatchNum;
  int? clickNum;
  int? realShareNum;
  int? commentNum;
  int? incomeCount;
  int? income;
  int? price;
  Creator? creator;
  int? videoType;
  int? videoStatus;
  int? source;
  String? platform;
  int? bgUserId;
  String? bgUserName;
  String? reviewDate;
  String? dynamicId;
  String? dynamicUserId;
  bool? cron;
  String? betId;
  double? score;
  String? createdAt;
  String? updatedAt;

  VideoInfoModel({
    this.id,
    this.previewId,
    this.videoId,
    this.title,
    this.videoUrl,
    this.previewUrl,
    this.coverImg,
    this.verticalImg,
    this.playTime,
    this.size,
    this.height,
    this.width,
    this.searchTitle,
    this.completeSplit,
    this.classify,
    this.tags,
    this.likes,
    this.realLikes,
    this.favorites,
    this.realFavorites,
    this.watchNum,
    this.realWatchNum,
    this.clickNum,
    this.realShareNum,
    this.commentNum,
    this.incomeCount,
    this.income,
    this.price,
    this.creator,
    this.videoType,
    this.videoStatus,
    this.source,
    this.platform,
    this.bgUserId,
    this.bgUserName,
    this.reviewDate,
    this.dynamicId,
    this.dynamicUserId,
    this.cron,
    this.betId,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id', this.id)
      ..put('previewId', this.previewId)
      ..put('videoId', this.videoId)
      ..put('title', this.title)
      ..put('videoUrl', this.videoUrl)
      ..put('previewUrl', this.previewUrl)
      ..put('coverImg', this.coverImg)
      ..put('verticalImg', this.verticalImg)
      ..put('playTime', this.playTime)
      ..put('size', this.size)
      ..put('height', this.height)
      ..put('width', this.width)
      ..put('searchTitle', this.searchTitle)
      ..put('completeSplit', this.completeSplit)
      ..put('classify', this.classify)
      ..put('tags', this.tags)
      ..put('likes', this.likes)
      ..put('realLikes', this.realLikes)
      ..put('favorites', this.favorites)
      ..put('realFavorites', this.realFavorites)
      ..put('watchNum', this.watchNum)
      ..put('realWatchNum', this.realWatchNum)
      ..put('clickNum', this.clickNum)
      ..put('realShareNum', this.realShareNum)
      ..put('commentNum', this.commentNum)
      ..put('incomeCount', this.incomeCount)
      ..put('income', this.income)
      ..put('price', this.price)
      ..put('creator', this.creator?.toJson())
      ..put('videoType', this.videoType)
      ..put('videoStatus', this.videoStatus)
      ..put('source', this.source)
      ..put('platform', this.platform)
      ..put('bgUserId', this.bgUserId)
      ..put('bgUserName', this.bgUserName)
      ..put('reviewDate', this.reviewDate)
      ..put('dynamicId', this.dynamicId)
      ..put('dynamicUserId', this.dynamicUserId)
      ..put('cron', this.cron)
      ..put('betId', this.betId)
      ..put('score', this.score)
      ..put('createdAt', this.createdAt)
      ..put('updatedAt', this.updatedAt);
  }

  VideoInfoModel.fromJson(Map<String, dynamic> json) {
    this.id = json.asString('id');
    this.previewId = json.asString('previewId');
    this.videoId = json.asInt('videoId');
    this.title = json.asString('title');
    this.videoUrl = json.asString('videoUrl');
    this.previewUrl = json.asString('previewUrl');
    this.coverImg = json.asString('coverImg');
    this.verticalImg = json.asString('verticalImg');
    this.playTime = json.asInt('playTime');
    this.size = json.asInt('size');
    this.height = json.asInt('height');
    this.width = json.asInt('width');
    this.searchTitle = json.asList<String>('searchTitle', null);
    this.completeSplit = json.asList<String>('completeSplit', null);
    this.classify = json.asList<String>('classify', null);
    this.tags = json.asList<String>('tags', null);
    this.likes = json.asInt('likes');
    this.realLikes = json.asInt('realLikes');
    this.favorites = json.asInt('favorites');
    this.realFavorites = json.asInt('realFavorites');
    this.watchNum = json.asInt('watchNum');
    this.realWatchNum = json.asInt('realWatchNum');
    this.clickNum = json.asInt('clickNum');
    this.realShareNum = json.asInt('realShareNum');
    this.commentNum = json.asInt('commentNum');
    this.incomeCount = json.asInt('incomeCount');
    this.income = json.asInt('income');
    this.price = json.asInt('price');
    this.creator = json.asBean(
        'creator', (v) => Creator.fromJson(v as Map<String, dynamic>));
    this.videoType = json.asInt('videoType');
    this.videoStatus = json.asInt('videoStatus');
    this.source = json.asInt('source');
    this.platform = json.asString('platform');
    this.bgUserId = json.asInt('bgUserId');
    this.bgUserName = json.asString('bgUserName');
    this.reviewDate = json.asString('reviewDate');
    this.dynamicId = json.asString('dynamicId');
    this.dynamicUserId = json.asString('dynamicUserId');
    this.cron = json.asBool('cron');
    this.betId = json.asString('betId');
    this.score = json.asDouble('score');
    this.createdAt = json.asString('createdAt');
    this.updatedAt = json.asString('updatedAt');
  }

  static VideoInfoModel toBean(Map<String, dynamic> json) =>
      VideoInfoModel.fromJson(json);
}

class Creator {
  int? userId;
  String? nickName;
  String? logo;
  int? vipType;
  String? gender;
  String? personSign;
  String? age;
  String? cityName;

  Creator({
    this.userId,
    this.nickName,
    this.logo,
    this.vipType,
    this.gender,
    this.personSign,
    this.age,
    this.cityName,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('userId', this.userId)
      ..put('nickName', this.nickName)
      ..put('logo', this.logo)
      ..put('vipType', this.vipType)
      ..put('gender', this.gender)
      ..put('personSign', this.personSign)
      ..put('age', this.age)
      ..put('cityName', this.cityName);
  }

  Creator.fromJson(Map<String, dynamic> json) {
    this.userId = json.asInt('userId');
    this.nickName = json.asString('nickName');
    this.logo = json.asString('logo');
    this.vipType = json.asInt('vipType');
    this.gender = json.asString('gender');
    this.personSign = json.asString('personSign');
    this.age = json.asString('age');
    this.cityName = json.asString('cityName');
  }
}
