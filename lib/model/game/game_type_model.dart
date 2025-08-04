import 'package:json2dart_safe/json2dart.dart';

class GameTypeModel {
  int? gameCollectionId;
  String? gameCollectionName;

  GameTypeModel({
    gameCollectionId,
    gameCollectionName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('gameCollectionId', gameCollectionId)
      ..put('gameCollectionName', gameCollectionName);
  }

  GameTypeModel.fromJson(Map<String, dynamic> json) {
    gameCollectionId = json.asInt('gameCollectionId');
    gameCollectionName = json.asString('gameCollectionName');
  }

  static GameTypeModel toBean(Map<String, dynamic> json) =>
      GameTypeModel.fromJson(json);
}
