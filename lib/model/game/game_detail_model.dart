import 'package:json2dart_safe/json2dart.dart';

class GameDetailModel {
  int? gameId;
  String? gameName;
  String? coverPicture;
  String? gameIntroduction;
  List<String>? publicityList;
  int? priceGold;
  String? tag;
  List<int>? gameCollectionIds;
  String? downUrl;
  String? extractionCode;
  String? pcDownUrl;
  int? hostType;
  String? gameOldVersion;
  String? gameLastVersion;
  String? newDownUrl;
  String? newPcDownUrl;
  String? newPriceGold;
  bool? ifBuyLastVersion;
  String? updateVersion;
  int? buyNum;
  String? cheatNum;
  int? cheatNumPrice;
  bool? buyGame;
  bool? buyCheat;

  GameDetailModel({
    gameId,
    gameName,
    coverPicture,
    gameIntroduction,
    publicityList,
    priceGold,
    tag,
    gameCollectionIds,
    downUrl,
    extractionCode,
    pcDownUrl,
    hostType,
    gameOldVersion,
    gameLastVersion,
    newDownUrl,
    newPcDownUrl,
    newPriceGold,
    ifBuyLastVersion,
    updateVersion,
    buyNum,
    cheatNum,
    cheatNumPrice,
    buyGame,
    buyCheat,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('gameId', gameId)
      ..put('gameName', gameName)
      ..put('coverPicture', coverPicture)
      ..put('gameIntroduction', gameIntroduction)
      ..put('publicityList', publicityList)
      ..put('priceGold', priceGold)
      ..put('tag', tag)
      ..put('gameCollectionIds', gameCollectionIds)
      ..put('downUrl', downUrl)
      ..put('extractionCode', extractionCode)
      ..put('pcDownUrl', pcDownUrl)
      ..put('hostType', hostType)
      ..put('gameOldVersion', gameOldVersion)
      ..put('gameLastVersion', gameLastVersion)
      ..put('newDownUrl', newDownUrl)
      ..put('newPcDownUrl', newPcDownUrl)
      ..put('newPriceGold', newPriceGold)
      ..put('ifBuyLastVersion', ifBuyLastVersion)
      ..put('updateVersion', updateVersion)
      ..put('buyNum', buyNum)
      ..put('cheatNum', cheatNum)
      ..put('cheatNumPrice', cheatNumPrice)
      ..put('buyGame', buyGame)
      ..put('buyCheat', buyCheat);
  }

  GameDetailModel.fromJson(Map<String, dynamic> json) {
    gameId = json.asInt('gameId');
    gameName = json.asString('gameName');
    coverPicture = json.asString('coverPicture');
    gameIntroduction = json.asString('gameIntroduction');
    publicityList = json.asList<String>('publicityList', null);
    priceGold = json.asInt('priceGold');
    tag = json.asString('tag');
    gameCollectionIds = json.asList<int>('gameCollectionIds', null);
    downUrl = json.asString('downUrl');
    extractionCode = json.asString('extractionCode');
    pcDownUrl = json.asString('pcDownUrl');
    hostType = json.asInt('hostType');
    gameOldVersion = json.asString('gameOldVersion');
    gameLastVersion = json.asString('gameLastVersion');
    newDownUrl = json.asString('newDownUrl');
    newPcDownUrl = json.asString('newPcDownUrl');
    newPriceGold = json.asString('newPriceGold');
    ifBuyLastVersion = json.asBool('ifBuyLastVersion');
    updateVersion = json.asString('updateVersion');
    buyNum = json.asInt('buyNum');
    cheatNum = json.asString('cheatNum');
    cheatNumPrice = json.asInt('cheatNumPrice');
    buyGame = json.asBool('buyGame');
    buyCheat = json.asBool('buyCheat');
  }

  static GameDetailModel toBean(Map<String, dynamic> json) =>
      GameDetailModel.fromJson(json);
}
