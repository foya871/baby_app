import 'package:json2dart_safe/json2dart.dart';

class ClassifyHotModel {
  int? classifyId;
  String? coverImg;
  String? createdAt;
  String? hotTitle;
  String? title;
  String? id;
  int? mark;
  int? sortNum;
  int? hotValue; //热度值
  String? updatedAt;
  int? videoMark;

  ClassifyHotModel.add(int this.hotValue, String this.hotTitle);

  ClassifyHotModel({
    this.classifyId,
    this.coverImg,
    this.createdAt,
    this.hotTitle,
    this.title,
    this.id,
    this.mark,
    this.hotValue,
    this.sortNum,
    this.updatedAt,
    this.videoMark,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('classifyId', this.classifyId)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('hotTitle', this.hotTitle)
      ..put('title', this.title)
      ..put('id', this.id)
      ..put('mark', this.mark)
      ..put('hotValue', this.hotValue)
      ..put('sortNum', this.sortNum)
      ..put('updatedAt', this.updatedAt)
      ..put('videoMark', this.videoMark);
  }

  ClassifyHotModel.fromJson(Map<String, dynamic> json) {
    this.classifyId = json.asInt('classifyId');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.hotTitle = json.asString('hotTitle');
    this.title = json.asString('title');
    this.id = json.asString('id');
    this.mark = json.asInt('mark');
    this.hotValue = json.asInt('hotValue');
    this.sortNum = json.asInt('sortNum');
    this.updatedAt = json.asString('updatedAt');
    this.videoMark = json.asInt('videoMark');
  }

  static ClassifyHotModel toBean(Map<String, dynamic> json) =>
      ClassifyHotModel.fromJson(json);
}
