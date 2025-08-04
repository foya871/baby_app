import 'package:json2dart_safe/json2dart.dart';

class SearchComicModel {
  int? comicsId;
  String? comicsTitle;
  String? info;
  String? coverImg;
  int? chapterNewNum;
  bool? isEnd;
  int? fakeLikes;
  int? fakeWatchTimes;
  String? createdAt;

  SearchComicModel({
    comicsId,
    comicsTitle,
    info,
    coverImg,
    chapterNewNum,
    isEnd,
    fakeLikes,
    fakeWatchTimes,
    createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('comicsId', comicsId)
      ..put('comicsTitle', comicsTitle)
      ..put('info', info)
      ..put('coverImg', coverImg)
      ..put('chapterNewNum', chapterNewNum)
      ..put('isEnd', isEnd)
      ..put('fakeLikes', fakeLikes)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('createdAt', createdAt);
  }

  SearchComicModel.fromJson(Map<dynamic, dynamic> json) {
    comicsId = json.asInt('comicsId');
    comicsTitle = json.asString('comicsTitle');
    info = json.asString('info');
    coverImg = json.asString('coverImg');
    chapterNewNum = json.asInt('chapterNewNum');
    isEnd = json.asBool('isEnd');
    fakeLikes = json.asInt('fakeLikes');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    createdAt = json.asString('createdAt');
  }

  static SearchComicModel toBean(Map<String, dynamic> json) =>
      SearchComicModel.fromJson(json);
}
