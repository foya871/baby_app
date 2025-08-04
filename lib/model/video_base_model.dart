import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/play/cdn_model.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../utils/enum.dart';
import '../utils/extension.dart';
import './axis_cover.dart';

class VideoBaseModel extends AxisCover {
  bool? attention;
  int? buyType;
  int? classifyId;
  String? collectionName;
  int? commentNum;
  List<String>? coverImg;
  String? createdAt;
  double? disPrice;
  int? fakeFavorites;
  int? fakeLikes;
  int? fakeShareNum;
  int? fakeWatchNum;
  bool? favorite;
  int? featuredOrFans;
  int? incomeCount;
  bool? like;
  String? logo;
  String? nickName;
  String? notPass;
  bool? officialRecommend;
  int? playTime;
  String? previewUrl;
  double? price;
  int? size;
  List<int>? stationIds;
  List<String>? stationNames;
  String? subtitle;
  List<String>? tagTitles;
  String? title;
  String? updatedAt;
  String? reviewDate;
  int? userId;
  List<String>? verticalImg;
  int? videoId;
  int? videoMark;
  VideoTypeEnum? videoType;
  CdnRsp? cdnRes;
  String? videoUrl;
  String? authKey;
  int? buyNum;
  bool? isSelected;
  int? height;
  int? width;
  int? mark;

  @override
  String get hCover => coverImg?.first ?? '';

  @override
  String get vCover => coverImg?.first ?? '';

  String get priceText => price?.toStringAsShort() ?? '';

  // 短视频
  bool get isShort => videoMark == 2;

  void onToggleLikeSuccess() {
    if (like == true) {
      int likes = (fakeLikes ?? 0) - 1;
      if (likes < 0) {
        likes = 0;
      }
      fakeLikes = likes;
    } else {
      fakeLikes = (fakeLikes ?? 0) + 1;
    }
    like = !(like ?? false);
  }

  VideoBaseModel(
      {this.attention,
      this.mark,
      this.height,
      this.width,
      this.buyType,
      this.classifyId,
      this.collectionName,
      this.commentNum,
      this.coverImg,
      this.createdAt,
      this.disPrice,
      this.fakeFavorites,
      this.fakeLikes,
      this.fakeShareNum,
      this.fakeWatchNum,
      this.favorite,
      this.featuredOrFans,
      this.incomeCount,
      this.like,
      this.logo,
      this.nickName,
      this.notPass,
      this.officialRecommend,
      this.playTime,
      this.previewUrl,
      this.price,
      this.size,
      this.stationIds,
      this.stationNames,
      this.subtitle,
      this.tagTitles,
      this.title,
      this.updatedAt,
      this.userId,
      this.verticalImg,
      this.videoId,
      this.videoMark,
      this.videoType,
      this.cdnRes,
      this.videoUrl,
      this.authKey,
      this.buyNum,
      this.isSelected,
      this.reviewDate});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('reviewDate', this.reviewDate)
      ..put('mark', this.mark)
      ..put('attention', this.attention)
      ..put('height', this.height)
      ..put('width', this.width)
      ..put('buyType', this.buyType)
      ..put('classifyId', this.classifyId)
      ..put('collectionName', this.collectionName)
      ..put('commentNum', this.commentNum)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('disPrice', this.disPrice)
      ..put('fakeFavorites', this.fakeFavorites)
      ..put('fakeLikes', this.fakeLikes)
      ..put('fakeShareNum', this.fakeShareNum)
      ..put('fakeWatchNum', this.fakeWatchNum)
      ..put('favorite', this.favorite)
      ..put('featuredOrFans', this.featuredOrFans)
      ..put('incomeCount', this.incomeCount)
      ..put('like', this.like)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('notPass', this.notPass)
      ..put('officialRecommend', this.officialRecommend)
      ..put('playTime', this.playTime)
      ..put('previewUrl', this.previewUrl)
      ..put('price', this.price)
      ..put('size', this.size)
      ..put('stationIds', this.stationIds)
      ..put('stationNames', this.stationNames)
      ..put('subtitle', this.subtitle)
      ..put('tags', this.tagTitles)
      ..put('title', this.title)
      ..put('updatedAt', this.updatedAt)
      ..put('userId', this.userId)
      ..put('verticalImg', this.verticalImg)
      ..put('videoId', this.videoId)
      ..put('videoMark', this.videoMark)
      ..put('videoType', this.videoType)
      ..put('cdnRes', this.cdnRes)
      ..put('videoUrl', this.videoUrl)
      ..put('authKey', this.authKey)
      ..put('buyNum', this.buyNum)
      ..put('isSelected', this.isSelected);
  }

  VideoBaseModel.fromJson(Map<String, dynamic> json) {
    this.attention = json.asBool('attention');
    this.buyType = json.asInt('buyType');
    this.mark = json.asInt('mark');
    this.width = json.asInt('width');
    this.height = json.asInt('height');
    this.classifyId = json.asInt('classifyId');
    this.collectionName = json.asString('collectionName');
    this.commentNum = json.asInt('commentNum');
    this.coverImg = json.asList<String>('coverImg') ?? [];
    this.createdAt = json.asString('createdAt');
    this.disPrice = json.asDouble('disPrice');
    this.fakeFavorites = json.asInt('fakeFavorites');
    this.fakeLikes = json.asInt('fakeLikes');
    this.fakeShareNum = json.asInt('fakeShareNum');
    this.fakeWatchNum = json.asInt('fakeWatchNum');
    this.favorite = json.asBool('favorite');
    this.featuredOrFans = json.asInt('featuredOrFans');
    this.incomeCount = json.asInt('incomeCount');
    this.like = json.asBool('like');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.notPass = json.asString('notPass');
    this.officialRecommend = json.asBool('officialRecommend');
    this.playTime = json.asInt('playTime');
    this.previewUrl = json.asString('previewUrl');
    this.price = json.asDouble('price');
    this.size = json.asInt('size');
    this.stationIds = json.asList<int>('stationIds', null);
    this.stationNames = json.asList<String>('stationNames', null);
    this.subtitle = json.asString('subtitle');
    this.tagTitles = json.asList<String>('tagTitles', null);
    this.title = json.asString('title');
    this.updatedAt = json.asString('updatedAt');
    this.reviewDate = json.asString('reviewDate');
    this.userId = json.asInt('userId');
    this.verticalImg = json.asList<String>('verticalImg', null);
    this.videoId = json.asInt('videoId');
    this.videoMark = json.asInt('videoMark');
    this.videoType = json.asInt('videoType');
    this.videoType = json.asInt('videoType');
    this.videoUrl = json.asString('videoUrl');
    this.authKey = json.asString('authKey');
    this.buyNum = json.asInt('buyNum');
    this.isSelected = json.asBool('isSelected');
    cdnRes = json.asBean(
        'cdnRes', (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v)));
  }

  static dynamic toBean(dynamic json) => VideoBaseModel.fromJson(json);

  VideoBaseModel.ad() : videoId = -999;
  bool get isVideAdMark => videoId == -999;
}

class VideoBaseModelWithIndex {
  final VideoBaseModel video;
  int index;

  int get rank => index + 1;

  VideoBaseModelWithIndex({required this.index, required this.video});

  static List<VideoBaseModelWithIndex> fromList(List<VideoBaseModel> vidoes,
      {int offset = 0}) {
    return List.generate(
      vidoes.length,
      (i) => VideoBaseModelWithIndex(index: i + offset, video: vidoes[i]),
    );
  }
}
