import 'package:json2dart_safe/json2dart.dart';

class ArchiveModel {
  String? accountNo;
  String? createdAt;
  String? info;
  String? type;
  int? userId;
  bool? showAll;
  bool? showZhan;

  ArchiveModel.add(
    String this.info,
  );

  ArchiveModel({
    this.accountNo,
    this.createdAt,
    this.info,
    this.type,
    this.userId,
    this.showAll,
    this.showZhan,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('accountNo', accountNo)
      ..put('createdAt', createdAt)
      ..put('info', info)
      ..put('type', type)
      ..put('userId', userId)
      ..put('showAll', showAll)
      ..put('showZhan', showZhan);
  }

  ArchiveModel.fromJson(Map<String, dynamic> json) {
    accountNo = json.asString('accountNo');
    createdAt = json.asString('createdAt');
    info = json.asString('info');
    type = json.asString('type');
    userId = json.asInt('userId');
    showAll = json.asBool('showAll');
    showZhan = json.asBool('showZhan');
  }

  static ArchiveModel toBean(dynamic json) => ArchiveModel.fromJson(json);
}
