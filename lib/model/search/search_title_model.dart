import 'package:json2dart_safe/json2dart.dart';

class SearchTitleModel {
  String? title;

  SearchTitleModel({
    this.title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}..put('title', title);
  }

  SearchTitleModel.fromJson(Map<String, dynamic> json) {
    title = json.asString('title');
  }

  static SearchTitleModel toBean(Map<String, dynamic> json) =>
      SearchTitleModel.fromJson(json);
}
