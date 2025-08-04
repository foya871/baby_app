import 'dart:convert';

import 'package:flutter/foundation.dart';

class RegionListModel {
  final List<ListHot> listHot;
  final List<ListRegion> listRegion;
  RegionListModel({
    required this.listHot,
    required this.listRegion,
  });

  RegionListModel copyWith({
    List<ListHot>? listHot,
    List<ListRegion>? listRegion,
  }) {
    return RegionListModel(
      listHot: listHot ?? this.listHot,
      listRegion: listRegion ?? this.listRegion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listHot': listHot.map((x) => x.toMap()).toList(),
      'listRegion': listRegion.map((x) => x.toMap()).toList(),
    };
  }

  factory RegionListModel.fromMap(Map<String, dynamic> map) {
    try {
      return RegionListModel(
        listHot: List<ListHot>.from(
          (map['listHot'] as List<dynamic>).map<ListHot>(
            (x) => ListHot.fromMap(x as Map<String, dynamic>),
          ),
        ),
        listRegion: List<ListRegion>.from(
          (map['listRegion'] as List<dynamic>).map<ListRegion>(
            (x) => ListRegion.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      return RegionListModel.fromJson("");
    }
  }

  String toJson() => json.encode(toMap());

  factory RegionListModel.fromJson(String source) =>
      RegionListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegionListModel(listHot: $listHot, listRegion: $listRegion)';

  @override
  bool operator ==(covariant RegionListModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.listHot, listHot) &&
        listEquals(other.listRegion, listRegion);
  }

  @override
  int get hashCode => listHot.hashCode ^ listRegion.hashCode;
}

class ListHot {
  final String code;
  final String initial;
  final bool isHot;
  final String name;
  final String parentCode;
  final String parentName;
  final String pinyin;
  final String suffix;
  ListHot({
    required this.code,
    required this.initial,
    required this.isHot,
    required this.name,
    required this.parentCode,
    required this.parentName,
    required this.pinyin,
    required this.suffix,
  });

  ListHot copyWith({
    String? code,
    String? initial,
    bool? isHot,
    String? name,
    String? parentCode,
    String? parentName,
    String? pinyin,
    String? suffix,
  }) {
    return ListHot(
      code: code ?? this.code,
      initial: initial ?? this.initial,
      isHot: isHot ?? this.isHot,
      name: name ?? this.name,
      parentCode: parentCode ?? this.parentCode,
      parentName: parentName ?? this.parentName,
      pinyin: pinyin ?? this.pinyin,
      suffix: suffix ?? this.suffix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'initial': initial,
      'isHot': isHot,
      'name': name,
      'parentCode': parentCode,
      'parentName': parentName,
      'pinyin': pinyin,
      'suffix': suffix,
    };
  }

  factory ListHot.fromMap(Map<String, dynamic> map) {
    return ListHot(
      code: map['code'] as String,
      initial: map['initial'] as String,
      isHot: map['isHot'] as bool,
      name: map['name'] as String,
      parentCode: map['parentCode'] as String,
      parentName: map['parentName'] as String,
      pinyin: map['pinyin'] as String,
      suffix: map['suffix'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListHot.fromJson(String source) =>
      ListHot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListHot(code: $code, initial: $initial, isHot: $isHot, name: $name, parentCode: $parentCode, parentName: $parentName, pinyin: $pinyin, suffix: $suffix)';
  }

  @override
  bool operator ==(covariant ListHot other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.initial == initial &&
        other.isHot == isHot &&
        other.name == name &&
        other.parentCode == parentCode &&
        other.parentName == parentName &&
        other.pinyin == pinyin &&
        other.suffix == suffix;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        initial.hashCode ^
        isHot.hashCode ^
        name.hashCode ^
        parentCode.hashCode ^
        parentName.hashCode ^
        pinyin.hashCode ^
        suffix.hashCode;
  }
}

class ListRegion {
  final String code;
  final String initial;
  final bool isHot;
  final String name;
  final String parentCode;
  final String parentName;
  final String pinyin;
  final String suffix;
  ListRegion({
    required this.code,
    required this.initial,
    required this.isHot,
    required this.name,
    required this.parentCode,
    required this.parentName,
    required this.pinyin,
    required this.suffix,
  });

  ListRegion copyWith({
    String? code,
    String? initial,
    bool? isHot,
    String? name,
    String? parentCode,
    String? parentName,
    String? pinyin,
    String? suffix,
  }) {
    return ListRegion(
      code: code ?? this.code,
      initial: initial ?? this.initial,
      isHot: isHot ?? this.isHot,
      name: name ?? this.name,
      parentCode: parentCode ?? this.parentCode,
      parentName: parentName ?? this.parentName,
      pinyin: pinyin ?? this.pinyin,
      suffix: suffix ?? this.suffix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'initial': initial,
      'isHot': isHot,
      'name': name,
      'parentCode': parentCode,
      'parentName': parentName,
      'pinyin': pinyin,
      'suffix': suffix,
    };
  }

  factory ListRegion.fromMap(Map<String, dynamic> map) {
    return ListRegion(
      code: map['code'] as String,
      initial: map['initial'] as String,
      isHot: map['isHot'] as bool,
      name: map['name'] as String,
      parentCode: map['parentCode'] as String,
      parentName: map['parentName'] as String,
      pinyin: map['pinyin'] as String,
      suffix: map['suffix'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListRegion.fromJson(String source) =>
      ListRegion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListRegion(code: $code, initial: $initial, isHot: $isHot, name: $name, parentCode: $parentCode, parentName: $parentName, pinyin: $pinyin, suffix: $suffix)';
  }

  @override
  bool operator ==(covariant ListRegion other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.initial == initial &&
        other.isHot == isHot &&
        other.name == name &&
        other.parentCode == parentCode &&
        other.parentName == parentName &&
        other.pinyin == pinyin &&
        other.suffix == suffix;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        initial.hashCode ^
        isHot.hashCode ^
        name.hashCode ^
        parentCode.hashCode ^
        parentName.hashCode ^
        pinyin.hashCode ^
        suffix.hashCode;
  }
}
