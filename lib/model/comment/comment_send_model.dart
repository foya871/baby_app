import 'package:json2dart_safe/json2dart.dart';

class CommentSendModel {
  String? content;
  int? gossipId;
  List<String>? img;
  int? parentId;
  int? topId;
  int? dynamicId;

  CommentSendModel({
    content,
    gossipId,
    img,
    parentId,
    topId,
    dynamicId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('content', content)
      ..put('gossipId', gossipId)
      ..put('img', img)
      ..put('parentId', parentId)
      ..put('topId', topId)
      ..put('dynamicId', dynamicId);
  }

  CommentSendModel.fromJson(Map<String, dynamic> json) {
    content = json.asString('content');
    gossipId = json.asInt('gossipId');
    img = json.asList<String>('img', null);
    parentId = json.asInt('parentId');
    topId = json.asInt('topId');
    dynamicId = json.asInt('dynamicId');
  }

  static CommentSendModel toBean(Map<String, dynamic> json) =>
      CommentSendModel.fromJson(json);
}
