import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/model/community/community_info_model.dart';
import 'package:baby_app/model/community/community_topic_model.dart';
import 'package:baby_app/model/community/community_video_model.dart';
import 'package:baby_app/model/community/creator_model.dart';
import 'package:json2dart_safe/json2dart.dart';

class CommunityModel {
  String? checkAt; //审核时间
  String? cityName; //城市名
  String? title;
  String? logo;
  String? nickName;
  CommunityTopicModel? topic;
  int? commentNum; //评论数
  int? fakeWatchTimes;
  int? fakeFavorites;
  String? content; //动态内容
  String? contentText; //动态内容
  List<CommunityInfoModel>? contents;
  String? createdAt; //创建时间
  int? dynamicId; //动态id
  int? dynamicType; //动态类型:1-图文 2-视频
  int? dynamicImgType; //动态图片类型：1-短图，2-长图
  List<String>? dynamicImg; //动态图片
  List<String>? images; //动态图片
  List<String>? tags;
  CreatorModel? creator;
  CommunityModel? topDynamicAll;
  CommunityModel? underDynamicAll;
  CommentDynamicModel? commentVo;
  CommunityVideoModel? video;
  int? fakeLikes; //伪造点赞次数
  int? likes;
  int? favorites;
  int? likesNum;
  int? realLikes; //真实点赞次数
  int? watchNum;
  int?
      vipType; //0-普通用户; 1-3天体验卡; 2-周卡; 3-金币周卡; 4-月卡; 7-黄金永久卡; 9-至尊卡; 11-暗网帝王卡; 12-星耀至尊卡
  bool? like; //是否点赞
  bool? isLike; //是否点赞
  bool? isFavorite; //是否收藏
  bool? isAttention; // 是否关注 接口没有这个参数
  bool? attention; // 是否关注
  bool? isUnlock; // 是否解锁
  bool? isUpUser; // 是否UP主
  bool? canWatch; // 是否能看
  double? gold; //价格
  double? imgHeight; //图片高度
  double? imgWidth; // 图片宽度
  int? status; //状态：1-未审核 2-已通过 3-已拒绝
  String? notPass; //审核不通过原因
  int? jumpType; //跳转类型 1、内部跳转 2、外部跳转
  String? jumpUrl; //跳转地址
  int? topSortNum; //置顶排序（大于0显示置顶标识）
  double? price;
  bool? topDynamic;
  int? reasonType; //1-vip 2-付费
  int? userId;
  List<String>? topicNames; // 话题
  List<String>? topics; // 话题
  int? dynamicMark; // 0-免费，1-vip，2-付费

  String get coverImg {
    if (contents == null || contents!.isEmpty) return '';
    for (final e in contents!) {
      var img = e.images?.firstOrNull;
      if (img != null && img.isNotEmpty) return img;
      img = e.video?.coverImg;
      if (img != null && img.isNotEmpty) return img;
      img = e.image;
      if (img != null && img.isNotEmpty) return img;
    }
    return '';
  }

  CommunityModel({
    this.checkAt,
    this.cityName,
    this.title,
    this.logo,
    this.nickName,
    this.topic,
    this.commentNum,
    this.fakeWatchTimes,
    this.fakeFavorites,
    this.content,
    this.contentText,
    this.contents,
    this.createdAt,
    this.dynamicId,
    this.dynamicType,
    this.dynamicImgType,
    this.dynamicImg,
    this.images,
    this.tags,
    this.creator,
    this.topDynamicAll,
    this.underDynamicAll,
    this.commentVo,
    this.video,
    this.fakeLikes,
    this.likes,
    this.favorites,
    this.likesNum,
    this.realLikes,
    this.watchNum,
    this.vipType,
    this.like,
    this.isLike,
    this.isFavorite,
    this.isAttention,
    this.attention,
    this.isUnlock,
    this.isUpUser,
    this.canWatch,
    this.gold,
    this.imgHeight,
    this.imgWidth,
    this.status,
    this.notPass,
    this.jumpType,
    this.jumpUrl,
    this.topSortNum,
    this.price,
    this.topDynamic,
    this.reasonType,
    this.userId,
    this.topicNames,
    this.topics,
    this.dynamicMark,
  });

  List<CommunityInfoModel> get videoContents =>
      contents?.where((e) => e.isVideo).toList() ?? [];

  // 最多一个video
  CommunityInfoModel? get videoContent => videoContents.firstOrNull;

  bool get hasVideo => videoContent != null;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('checkAt', checkAt)
      ..put('cityName', cityName)
      ..put('title', title)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('topic', topic)
      ..put('commentNum', commentNum)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('fakeFavorites', fakeFavorites)
      ..put('content', content)
      ..put('contentText', contentText)
      ..put('contents', contents)
      ..put('createdAt', createdAt)
      ..put('dynamicId', dynamicId)
      ..put('dynamicType', dynamicType)
      ..put('dynamicImgType', dynamicImgType)
      ..put('dynamicImg', dynamicImg)
      ..put('images', images)
      ..put('tags', tags)
      ..put('creator', creator)
      ..put('topDynamicAll', topDynamicAll)
      ..put('underDynamicAll', underDynamicAll)
      ..put('commentVo', commentVo)
      ..put('video', video)
      ..put('fakeLikes', fakeLikes)
      ..put('likes', likes)
      ..put('favorites', favorites)
      ..put('likesNum', likesNum)
      ..put('realLikes', realLikes)
      ..put('watchNum', watchNum)
      ..put('vipType', vipType)
      ..put('like', like)
      ..put('isLike', isLike)
      ..put('isFavorite', isFavorite)
      ..put('isAttention', isAttention)
      ..put('attention', attention)
      ..put('isUnlock', isUnlock)
      ..put('isUpUser', isUpUser)
      ..put('canWatch', canWatch)
      ..put('gold', gold)
      ..put('imgHeight', imgHeight)
      ..put('imgWidth', imgWidth)
      ..put('status', status)
      ..put('notPass', notPass)
      ..put('jumpType', jumpType)
      ..put('jumpUrl', jumpUrl)
      ..put('topSortNum', topSortNum)
      ..put('price', price)
      ..put('topDynamic', topDynamic)
      ..put('reasonType', reasonType)
      ..put('userId', userId)
      ..put('topicNames', topicNames)
      ..put('topics', topics)
      ..put('dynamicMark', dynamicMark);
  }

  CommunityModel.fromJson(Map<String, dynamic> json) {
    checkAt = json.asString('checkAt');
    cityName = json.asString('cityName');
    title = json.asString('title');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    topic = json.asBean('topic',
        (v) => CommunityTopicModel.fromJson(Map<String, dynamic>.from(v)));
    commentNum = json.asInt('commentNum');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    fakeFavorites = json.asInt('fakeFavorites');
    content = json.asString('content');
    contentText = json.asString('contentText');
    contents =
        json.asList<CommunityInfoModel>('contents', CommunityInfoModel.toBean);
    createdAt = json.asString('createdAt');
    dynamicId = json.asInt('dynamicId');
    dynamicType = json.asInt('dynamicType');
    dynamicImgType = json.asInt('dynamicImgType');
    dynamicImg = json.asList<String>('dynamicImg');
    images = json.asList<String>('images');
    tags = json.asList<String>('tags');
    creator = json.asBean(
        'creator', (v) => CreatorModel.fromJson(Map<String, dynamic>.from(v)));
    topDynamicAll = json.asBean('topDynamicAll',
        (v) => CommunityModel.fromJson(Map<String, dynamic>.from(v)));
    underDynamicAll = json.asBean('underDynamicAll',
        (v) => CommunityModel.fromJson(Map<String, dynamic>.from(v)));
    commentVo = json.asBean('commentVo',
        (v) => CommentDynamicModel.fromJson(Map<String, dynamic>.from(v)));
    video = json.asBean('video',
        (v) => CommunityVideoModel.fromJson(Map<String, dynamic>.from(v)));
    fakeLikes = json.asInt('fakeLikes');
    likes = json.asInt('likes');
    favorites = json.asInt('favorites');
    likesNum = json.asInt('likesNum');
    realLikes = json.asInt('realLikes');
    watchNum = json.asInt('watchNum');
    vipType = json.asInt('vipType');
    like = json.asBool('like');
    isLike = json.asBool('isLike');
    isFavorite = json.asBool('isFavorite');
    isAttention = json.asBool('isAttention');
    attention = json.asBool('attention');
    isUnlock = json.asBool('isUnlock');
    isUpUser = json.asBool('isUpUser');
    canWatch = json.asBool('canWatch');
    gold = json.asDouble('gold');
    imgHeight = json.asDouble('imgHeight');
    imgWidth = json.asDouble('imgWidth');
    status = json.asInt('status');
    notPass = json.asString('notPass');
    jumpType = json.asInt('jumpType');
    jumpUrl = json.asString('jumpUrl');
    topSortNum = json.asInt('topSortNum');
    price = json.asDouble('price');
    topDynamic = json.asBool('topDynamic');
    reasonType = json.asInt('reasonType');
    userId = json.asInt('userId');
    topicNames = json.asList<String>('topicNames');
    topics = json.asList<String>('topics');
    dynamicMark = json.asInt('dynamicMark');
  }

  static CommunityModel toBean(dynamic json) => CommunityModel.fromJson(json);
}
