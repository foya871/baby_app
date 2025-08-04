import 'package:json2dart_safe/json2dart.dart';

import '../utils/enum.dart';
import 'video_base_model.dart';

// 频道
class StationModel {
  final String coverImg;
  final String info;
  final int stationId;
  final String stationName;
  final StationType type;
  final List<VideoBaseModel> videoList;

  StationModel.empty() : this.fromJson({});

  bool get isEmpty => stationId == 0;
  int get pageSize => StationTypeEnum.pageSize(type);

  StationDetailStyle get detailStyle => StationTypeEnum.getDetailStyle(type);
  bool get isRank => StationTypeEnum.isRank(type);
  bool get showMoreAndChangeRow => StationTypeEnum.showMoreAndChange(type);

  StationModel.fromJson(Map<String, dynamic> json)
      : coverImg = json.asString('coverImg'),
        info = json.asString('info'),
        stationId = json.asInt('stationId'),
        stationName = json.asString('stationName'),
        type = json.asInt('type', StationTypeEnum.none),
        videoList =
            json.asList<VideoBaseModel>('videoList', VideoBaseModel.toBean) ??
                [];

  static dynamic toBean(dynamic json) => StationModel.fromJson(json);
}
