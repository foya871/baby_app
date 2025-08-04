import 'package:json2dart_safe/json2dart.dart';

const _allId = '00000';

class CommunityClassifyModel {
  String? id;
  String? userId;
  String? name;
  String? logo;
  String? backgroundImg;
  String? introduction;
  int? joinNum;
  int? classifyId;
  int? postNum;
  bool? isHot;
  bool? isJoined;

  bool get isAll => id == _allId;

  CommunityClassifyModel.all()
      : id = _allId,
        name = '全部';

  CommunityClassifyModel({
    this.id,
    this.userId,
    this.name,
    this.logo,
    this.backgroundImg,
    this.introduction,
    this.joinNum,
    this.classifyId,
    this.postNum,
    this.isHot,
    this.isJoined,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('userId', userId)
      ..put('name', name)
      ..put('logo', logo)
      ..put('backgroundImg', backgroundImg)
      ..put('introduction', introduction)
      ..put('joinNum', joinNum)
      ..put('classifyId', classifyId)
      ..put('postNum', postNum)
      ..put('isHot', isHot)
      ..put('isJoined', isJoined);
  }

  CommunityClassifyModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    userId = json.asString('userId');
    name = json.asString('name');
    logo = json.asString('logo');
    backgroundImg = json.asString('backgroundImg');
    introduction = json.asString('introduction');
    joinNum = json.asInt('joinNum');
    classifyId = json.asInt('classifyId');
    postNum = json.asInt('postNum');
    isHot = json.asBool('isHot');
    isJoined = json.asBool('isJoined');
  }

  static CommunityClassifyModel toBean(dynamic json) =>
      CommunityClassifyModel.fromJson(json);
}
