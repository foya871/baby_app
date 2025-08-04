import 'package:json2dart_safe/json2dart.dart';

class Station {
  int? stationId;
  String? stationName;

  Station({
    this.stationId,
    this.stationName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('stationId', this.stationId)
      ..put('stationName', this.stationName);
  }

  Station.fromJson(Map<String, dynamic> json) {
    this.stationId = json.asInt('stationId');
    this.stationName = json.asString('stationName');
  }

  static Station toBean(Map<String, dynamic> json) => Station.fromJson(json);
}
