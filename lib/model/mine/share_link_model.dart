import 'package:json2dart_safe/json2dart.dart';

class ShareRespModel {
  String? inviteCode;
  int? inviteUserNum;
  String? linkText;
  String? url;

  ShareRespModel({
    this.inviteCode,
    this.inviteUserNum,
    this.linkText,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('inviteCode', this.inviteCode)
      ..put('inviteUserNum', this.inviteUserNum)
      ..put('linkText', this.linkText)
      ..put('url', this.url);
  }

  ShareRespModel.fromJson(Map<String, dynamic> json) {
    this.inviteCode = json.asString('inviteCode');
    this.inviteUserNum = json.asInt('inviteUserNum');
    this.linkText = json.asString('linkText');
    this.url = json.asString('url');
  }

  static ShareRespModel toBean(Map<String, dynamic> json) =>
      ShareRespModel.fromJson(json);
}
