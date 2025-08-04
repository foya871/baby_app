import 'package:json2dart_safe/json2dart.dart';

const _allTagsTitleName = '全部标签';
const _allTagsTitleId = -98765431;
const _logo = "";

class TagsModel {
  final int tagsId;
  final String tagsTitle;
  final String logo;

  bool get isAll => tagsId == _allTagsTitleId;

  bool get isEmpty => tagsId == 0;

  TagsModel.empty() : this.fromJson({});

  TagsModel.all()
      : tagsId = _allTagsTitleId,
        tagsTitle = _allTagsTitleName,
        logo = _logo;

  TagsModel.fromJson(Map<String, dynamic> json)
      : tagsId = json.asInt('tagsId', 0),
        tagsTitle = json.asString('tagsTitle', ''),
        logo = json.asString('logo', '');

  static dynamic toBean(dynamic json) => TagsModel.fromJson(json);
}
