import 'package:json2dart_safe/json2dart.dart';

class CommonTagModel {
  int? tagId;
  String? title;

  CommonTagModel({
    this.tagId,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('tagId', this.tagId)
      ..put('title', this.title);
  }

  CommonTagModel.fromJson(Map<String, dynamic> json) {
    this.tagId = json.asInt('tagId');
    this.title = json.asString('title');
  }
}
