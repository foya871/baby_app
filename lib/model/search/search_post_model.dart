import 'package:json2dart_safe/json2dart.dart';

class SearchPostModel {
  int? dynamicId;
  int? dynamicType;
  Creator? creator;
  String? title;
  String? coverImg;
  String? images;
  List<Contents>? contents;
  bool? isLike;
  bool? isFavorite;
  int? likes;
  int? favorites;
  int? watchNum;
  int? commentNum;
  bool? topDynamic;
  int? status;
  String? notPass;
  bool? isAttention;
  String? jumpType;
  String? jumpUrl;
  String? topicNames;
  String? checkAt;
  String? commentVo;

  SearchPostModel({
    dynamicId,
    dynamicType,
    creator,
    title,
    coverImg,
    images,
    contents,
    isLike,
    isFavorite,
    likes,
    favorites,
    watchNum,
    commentNum,
    topDynamic,
    status,
    notPass,
    isAttention,
    jumpType,
    jumpUrl,
    topicNames,
    checkAt,
    commentVo,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dynamicId', dynamicId)
      ..put('dynamicType', dynamicType)
      ..put('creator', creator?.toJson())
      ..put('title', title)
      ..put('coverImg', coverImg)
      ..put('images', images)
      ..put('contents', contents?.map((v) => v.toJson()).toList())
      ..put('isLike', isLike)
      ..put('isFavorite', isFavorite)
      ..put('likes', likes)
      ..put('favorites', favorites)
      ..put('watchNum', watchNum)
      ..put('commentNum', commentNum)
      ..put('topDynamic', topDynamic)
      ..put('status', status)
      ..put('notPass', notPass)
      ..put('isAttention', isAttention)
      ..put('jumpType', jumpType)
      ..put('jumpUrl', jumpUrl)
      ..put('topicNames', topicNames)
      ..put('checkAt', checkAt)
      ..put('commentVo', commentVo);
  }

  SearchPostModel.fromJson(Map<dynamic, dynamic> json) {
    dynamicId = json.asInt('dynamicId');
    dynamicType = json.asInt('dynamicType');
    creator = json.asBean('creator', (v) => Creator.fromJson(v));
    title = json.asString('title');
    coverImg = json.asString('coverImg');
    images = json.asString('images');
    contents = json.asList<Contents>('contents', (v) => Contents.fromJson(v));
    isLike = json.asBool('isLike');
    isFavorite = json.asBool('isFavorite');
    likes = json.asInt('likes');
    favorites = json.asInt('favorites');
    watchNum = json.asInt('watchNum');
    commentNum = json.asInt('commentNum');
    topDynamic = json.asBool('topDynamic');
    status = json.asInt('status');
    notPass = json.asString('notPass');
    isAttention = json.asBool('isAttention');
    jumpType = json.asString('jumpType');
    jumpUrl = json.asString('jumpUrl');
    topicNames = json.asString('topicNames');
    checkAt = json.asString('checkAt');
    commentVo = json.asString('commentVo');
  }

  static SearchPostModel toBean(Map<String, dynamic> json) =>
      SearchPostModel.fromJson(json);
}

class Creator {
  int? userId;
  String? nickName;
  String? logo;
  int? vipType;
  int? gender;
  String? personSign;
  String? age;
  String? cityName;

  Creator({
    userId,
    nickName,
    logo,
    vipType,
    gender,
    personSign,
    age,
    cityName,
  });

  Map<dynamic, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('userId', userId)
      ..put('nickName', nickName)
      ..put('logo', logo)
      ..put('vipType', vipType)
      ..put('gender', gender)
      ..put('personSign', personSign)
      ..put('age', age)
      ..put('cityName', cityName);
  }

  Creator.fromJson(Map<dynamic, dynamic> json) {
    userId = json.asInt('userId');
    nickName = json.asString('nickName');
    logo = json.asString('logo');
    vipType = json.asInt('vipType');
    gender = json.asInt('gender');
    personSign = json.asString('personSign');
    age = json.asString('age');
    cityName = json.asString('cityName');
  }
}

class Video {
  String? id;
  String? title;
  String? resourceTitle;
  String? videoUrl;
  String? coverImg;
  int? playTime;
  int? height;
  int? width;
  String? authKey;
  String? cdnId;

  Video({
    id,
    title,
    resourceTitle,
    videoUrl,
    coverImg,
    playTime,
    height,
    width,
    authKey,
    cdnId,
  });

  Map<dynamic, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('title', title)
      ..put('resourceTitle', resourceTitle)
      ..put('videoUrl', videoUrl)
      ..put('coverImg', coverImg)
      ..put('playTime', playTime)
      ..put('height', height)
      ..put('width', width)
      ..put('authKey', authKey)
      ..put('cdnId', cdnId);
  }

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json.asString('id');
    title = json.asString('title');
    resourceTitle = json.asString('resourceTitle');
    videoUrl = json.asString('videoUrl');
    coverImg = json.asString('coverImg');
    playTime = json.asInt('playTime');
    height = json.asInt('height');
    width = json.asInt('width');
    authKey = json.asString('authKey');
    cdnId = json.asString('cdnId');
  }
}

class Contents {
  int? type;
  String? text;
  String? images;
  Video? video;

  Contents({
    type,
    text,
    images,
    video,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('type', type)
      ..put('text', text)
      ..put('images', images)
      ..put('video', video?.toJson());
  }

  Contents.fromJson(Map<dynamic, dynamic> json) {
    type = json.asInt('type');
    text = json.asString('text');
    images = json.asString('images');
    video = json.asBean('video', (v) => Video.fromJson(v));
  }
}
