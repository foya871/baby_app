import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/city_model.dart';

class CityListModel {
  List<CityModel>? listHot; //热门城市
  List<CityModel>? listRegion; //行政区域list

  CityListModel({
    this.listHot,
    this.listRegion,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('listHot', listHot?.map((v) => v.toJson()).toList())
      ..put('listRegion', listRegion?.map((v) => v.toJson()).toList());
  }

  CityListModel.fromJson(Map<String, dynamic> json) {
    listHot = json.asList<CityModel>('listHot', CityModel.toBean);
    listRegion = json.asList<CityModel>('listRegion', CityModel.toBean);
  }

  static CityListModel toBean(dynamic json) => CityListModel.fromJson(json);
}
