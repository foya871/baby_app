import 'package:json2dart_safe/json2dart.dart';

class VideoLabelModel {
  int? tagsId;
  String? tagsTitle;
  bool? isSelect;

  VideoLabelModel({
    this.tagsId,
    this.tagsTitle,
    this.isSelect,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('tagsId', tagsId)
      ..put('tagsTitle', tagsTitle)
      ..put('isSelect', isSelect);
  }

  VideoLabelModel.fromJson(Map<String, dynamic> json) {
    tagsId = json.asInt('tagsId');
    tagsTitle = json.asString('tagsTitle');
    isSelect = json.asBool('isSelect');
  }

  static VideoLabelModel toBean(dynamic json) => VideoLabelModel.fromJson(json);
}
