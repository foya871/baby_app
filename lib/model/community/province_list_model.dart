import 'package:json2dart_safe/json2dart.dart';
import 'package:baby_app/model/community/province_model.dart';

class ProvinceListModel {
  List<ProvinceModel>? data;

  ProvinceListModel({
    this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('data', data?.map((v) => v.toJson()).toList());
  }

  ProvinceListModel.fromJson(Map<String, dynamic> json) {
    data = json.asList<ProvinceModel>('data', ProvinceModel.toBean);
  }

  static ProvinceListModel toBean(dynamic json) =>
      ProvinceListModel.fromJson(json);
}
