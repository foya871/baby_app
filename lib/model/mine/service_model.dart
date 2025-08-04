import 'package:json2dart_safe/json2dart.dart';

class ServiceModel {
  String? signUrl;
  String? url;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('signUrl', signUrl)
      ..put('url', url);
  }

  ServiceModel.fromJson(Map<String, dynamic> json) {
    signUrl = json.asString('signUrl');
    url = json.asString('url');
  }

  dynamic toBean(Map<String, dynamic> json) => ServiceModel.fromJson(json);
}
