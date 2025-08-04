import 'package:json2dart_safe/json2dart.dart';

class SearchHotSpotModel {
  int? videoId;
  String? title;
  String? coverImg;
  String? verticalImg;
  int? playTime;
  int? size;
  int? height;
  int? width;
  List<String>? tags;
  int? likes;
  int? favorites;
  int? watchNum;
  int? realShareNum;
  int? commentNum;
  int? price;
  int? videoType;
  String? reviewDate;
  int? clickNum;
  String? createdAt;

  SearchHotSpotModel({
    videoId,
    title,
    coverImg,
    verticalImg,
    playTime,
    size,
    height,
    width,
    tags,
    likes,
    favorites,
    watchNum,
    realShareNum,
    commentNum,
    price,
    videoType,
    reviewDate,
    clickNum,
    createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('videoId', videoId)
      ..put('title', title)
      ..put('coverImg', coverImg)
      ..put('verticalImg', verticalImg)
      ..put('playTime', playTime)
      ..put('size', size)
      ..put('height', height)
      ..put('width', width)
      ..put('tags', tags)
      ..put('likes', likes)
      ..put('favorites', favorites)
      ..put('watchNum', watchNum)
      ..put('realShareNum', realShareNum)
      ..put('commentNum', commentNum)
      ..put('price', price)
      ..put('videoType', videoType)
      ..put('reviewDate', reviewDate)
      ..put('clickNum', clickNum)
      ..put('createdAt', createdAt);
  }

  SearchHotSpotModel.fromJson(Map<String, dynamic> json) {
    videoId = json.asInt('videoId');
    title = json.asString('title');
    coverImg = json.asString('coverImg');
    verticalImg = json.asString('verticalImg');
    playTime = json.asInt('playTime');
    size = json.asInt('size');
    height = json.asInt('height');
    width = json.asInt('width');
    tags = json.asList<String>('tags', null);
    likes = json.asInt('likes');
    favorites = json.asInt('favorites');
    watchNum = json.asInt('watchNum');
    realShareNum = json.asInt('realShareNum');
    commentNum = json.asInt('commentNum');
    price = json.asInt('price');
    videoType = json.asInt('videoType');
    reviewDate = json.asString('reviewDate');
    clickNum = json.asInt('clickNum');
    createdAt = json.asString('createdAt');
  }

  static SearchHotSpotModel toBean(Map<String, dynamic> json) =>
      SearchHotSpotModel.fromJson(json);
}
