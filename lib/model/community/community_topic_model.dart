import 'package:json2dart_safe/json2dart.dart';

class CommunityTopicModel {
  bool? hot; //是否热门
  String? id; //话题id
  String? introduction; //话题简介
  String? logo; //话题头像
  String? backgroundImg; //话题背景图
  String? name; //话题名
  String? refreshAt; //帖子更新时间
  int? participate; //参与人数
  List<String>? participateLogo; //参与人头像
  int? postNum; //话题动态数
  int? watchNum; //浏览次数
  int? subscribeNum; //圈子参加人数
  int? fakeLikeNum; //伪造被关注次数
  int? fakeWatchTimes; //伪造被观看次数
  bool? isAttention;
  bool? isMore;
  bool? subscribe;
  bool? selected;
  bool? participated;

  CommunityTopicModel.empty() : this.fromJson({});

  CommunityTopicModel.add(String this.name);

  CommunityTopicModel({
    this.hot,
    this.id,
    this.introduction,
    this.logo,
    this.backgroundImg,
    this.name,
    this.refreshAt,
    this.participate,
    this.participateLogo,
    this.postNum,
    this.watchNum,
    this.subscribeNum,
    this.fakeLikeNum,
    this.fakeWatchTimes,
    this.isAttention,
    this.isMore,
    this.subscribe,
    this.selected,
    this.participated,
  });

  CommunityTopicModel copy() {
    return CommunityTopicModel(
      name: name,
      selected: selected,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('hot', hot)
      ..put('id', id)
      ..put('introduction', introduction)
      ..put('logo', logo)
      ..put('backgroundImg', backgroundImg)
      ..put('name', name)
      ..put('refreshAt', refreshAt)
      ..put('participate', participate)
      ..put('participateLogo', participateLogo)
      ..put('postNum', postNum)
      ..put('watchNum', watchNum)
      ..put('subscribeNum', subscribeNum)
      ..put('fakeLikeNum', fakeLikeNum)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('isAttention', isAttention)
      ..put('subscribe', subscribe)
      ..put('selected', selected)
      ..put('participated', participated)
      ..put('isMore', isMore);
  }

  CommunityTopicModel.fromJson(Map<String, dynamic> json) {
    hot = json.asBool('hot');
    id = json.asString('id');
    introduction = json.asString('introduction');
    logo = json.asString('logo');
    backgroundImg = json.asString('backgroundImg');
    name = json.asString('name');
    refreshAt = json.asString('refreshAt');
    participate = json.asInt('participate');
    participateLogo = json.asList<String>('participateLogo');
    postNum = json.asInt('postNum');
    watchNum = json.asInt('watchNum');
    fakeLikeNum = json.asInt('fakeLikeNum');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    subscribeNum = json.asInt('subscribeNum');
    isAttention = json.asBool('isAttention');
    isMore = json.asBool('isMore');
    selected = json.asBool('selected');
    participated = json.asBool('participated');
    subscribe = json.asBool('subscribe');
  }

  static CommunityTopicModel toBean(dynamic json) =>
      CommunityTopicModel.fromJson(json);
}
