import 'package:json2dart_safe/json2dart.dart';
import 'partner_list.dart';

class SysPartnerStationCellModel {
  String? createdAt;
  String? id;
  String? name;
  List<PartnerList>? partnerList;
  int? sortNum;
  int? stationId;
  int? type;
  String? updatedAt;
  int? viewType;

  SysPartnerStationCellModel({
    this.createdAt,
    this.id,
    this.name,
    this.partnerList,
    this.sortNum,
    this.stationId,
    this.type,
    this.updatedAt,
    this.viewType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('name', this.name)
      ..put('partnerList', this.partnerList?.map((e) => e.toJson()).toList())
      ..put('sortNum', this.sortNum)
      ..put('stationId', this.stationId)
      ..put('type', this.type)
      ..put('updatedAt', this.updatedAt)
      ..put('viewType', this.viewType);
  }

  SysPartnerStationCellModel.fromJson(Map<String, dynamic> json) {
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.name = json.asString('name');
    this.partnerList = json.asList<PartnerList>(
        'partnerList', (e) => PartnerList.fromJson(e as Map<String, dynamic>));
    this.sortNum = json.asInt('sortNum');
    this.stationId = json.asInt('stationId');
    this.type = json.asInt('type');
    this.updatedAt = json.asString('updatedAt');
    this.viewType = json.asInt('viewType');
  }

  static SysPartnerStationCellModel toBean(Map<String, dynamic> json) =>
      SysPartnerStationCellModel.fromJson(json);
}
