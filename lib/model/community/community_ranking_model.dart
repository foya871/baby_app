import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/community_model.dart';

class CommunityRankingModel {
  int? total;
  List<CommunityModel>? data;

  CommunityRankingModel({
    this.total,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('total', total)
      ..put('data', data?.map((v) => v.toJson()).toList());
  }

  CommunityRankingModel.fromJson(Map<String, dynamic> json) {
    total = json.asInt('total');
    data = json.asList<CommunityModel>('data', CommunityModel.toBean);
  }

  static CommunityRankingModel toBean(dynamic json) =>
      CommunityRankingModel.fromJson(json);
}
