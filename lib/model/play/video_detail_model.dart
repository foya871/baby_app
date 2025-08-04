/*
 * @Author: wangdazhuang
 * @Date: 2025-02-19 19:31:35
 * @LastEditTime: 2025-07-19 18:10:28
 * @LastEditors: Please set LastEditors
 * @Description: 
 * @FilePath: /baby_app/lib/model/play/video_detail_model.dart
 */
import 'package:get/get.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/env/environment_service.dart';
import 'package:baby_app/services/user_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../utils/enum.dart';
import '../axis_cover.dart';
import 'cdn_model.dart';

class VideoDetail extends AxisCover {
  bool? isAttention;
  bool? canWatch;
  String? checkSum;
  int? commentNum;
  List<String>? coverImg;
  String? createdAt;
  int? fakeFavorites;
  int? fakeLikes;
  bool? isLike;
  bool? favorite;
  int? height;
  int? fakeWatchNum;
  int? fakeShareNum;

  String? logo;
  String? nickName;
  String? playPath;
  int? playTime;
  double? price;
  VideoReasonTypeEnum? reasonType;
  int? size;
  List<String>? tagTitles;
  String? title;
  int? userId;
  int? videoId;
  int? videoType;
  String? videoUrl;
  int? width;
  String? authKey;
  CdnRsp? cdnRes;
  int? bu;
  int? workNum;
  List<int>? videoIds;

  String get playerPath => Environment.buildAuthPlayUrlString(
      videoUrl: videoUrl, authKey: authKey, id: cdnRes?.id);

  @override
  String get vCover => coverImg?.firstOrNull ?? '';
  @override
  String get hCover => coverImg?.firstOrNull ?? '';
  String get priceText => price?.toStringAsShort() ?? '';
  double get discountPrice {
    final originPrice = price ?? 0;
    final discount = Get.find<UserService>().user.vipGoldVideoDis ?? 0;
    if (discount > 0) {
      return originPrice * discount;
    }
    return originPrice;
  }

  void onToggleLikeSuccess() {
    final old = isLike ?? false;
    if (old) {
      fakeLikes = fakeLikes! - 1;
      if (fakeLikes! < 0) {
        fakeLikes = 0;
      }
    } else {
      fakeLikes = fakeLikes! + 1;
    }
    isLike = !old;
  }

  void onToggleFavSuccess() {
    final old = favorite ?? false;
    if (old) {
      fakeFavorites = fakeFavorites! - 1;
      if (fakeFavorites! < 0) {
        fakeFavorites = 0;
      }
    } else {
      fakeFavorites = fakeFavorites! + 1;
    }
    favorite = !old;
  }

  void onToggleAttentionSuccess() {
    final old = isAttention ?? false;
    isAttention = !old;
  }

  VideoDetail.fromJson(Map<String, dynamic> json) {
    canWatch = json.asBool('canWatch');
    checkSum = json.asString('checkSum');
    commentNum = json.asInt('commentNum');
    coverImg = json.asList<String>('coverImg');
    createdAt = json.asString('createdAt');
    fakeFavorites = json.asInt('fakeFavorites');
    fakeLikes = json.asInt('fakeLikes');
    height = json.asInt('height');
    if (json.containsKey("isLike")) {
      isLike = json.asBool('isLike');
    } else {
      isLike = json.asBool('like');
    }
    if (json.containsKey("isFavorite")) {
      favorite = json.asBool("isFavorite");
    } else {
      favorite = json.asBool("favorite");
    }
    if (json.containsKey("isAttention")) {
      isAttention = json.asBool('isAttention');
    } else {
      isAttention = json.asBool('attention');
    }

    fakeWatchNum = json.asInt("fakeWatchNum");
    fakeShareNum = json.asInt("fakeShareNum");
    // 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';
    playPath = json.asString('playPath');
    playTime = json.asInt('playTime');
    price = json.asDouble('price');
    reasonType = json.asInt('reasonType');
    size = json.asInt('size');
    tagTitles = json.asList<String>('tagTitles');
    title = json.asString('title');
    videoId = json.asInt('videoId');
    videoType = json.asInt('videoType');
    videoUrl = json.asString('videoUrl');
    width = json.asInt('width');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    userId = json.asInt('userId');
    cdnRes = json.asBean(
        "cdnRes", (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v)));
    authKey = json.asString("authKey");
    bu = json.asInt('bu');
    workNum = json.asInt('workNum');
    videoIds = json.asList<int>('videoIds');
  }

  static dynamic toBean(Map json) =>
      VideoDetail.fromJson(Map<String, dynamic>.from(json));
}
