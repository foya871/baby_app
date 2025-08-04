import 'dart:convert';

class HotRegionListModel {
  final String? code;
  final String? createdAt;
  final int? distinctId;
  final String? id;
  final String? initial;
  final String? initials;
  final bool? isHot;
  final String? name;
  final String? parentCode;
  final int? parentId;
  final String? parentName;
  final String? pinyin;
  final String? suffix;
  final String? updatedAt;

  HotRegionListModel({
    this.code,
    this.createdAt,
    this.distinctId,
    this.id,
    this.initial,
    this.initials,
    this.isHot,
    this.name,
    this.parentCode,
    this.parentId,
    this.parentName,
    this.pinyin,
    this.suffix,
    this.updatedAt,
  });

  HotRegionListModel copyWith({
    String? code,
    String? createdAt,
    int? distinctId,
    String? id,
    String? initial,
    String? initials,
    bool? isHot,
    String? name,
    String? parentCode,
    int? parentId,
    String? parentName,
    String? pinyin,
    String? suffix,
    String? updatedAt,
  }) {
    return HotRegionListModel(
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      distinctId: distinctId ?? this.distinctId,
      id: id ?? this.id,
      initial: initial ?? this.initial,
      initials: initials ?? this.initials,
      isHot: isHot ?? this.isHot,
      name: name ?? this.name,
      parentCode: parentCode ?? this.parentCode,
      parentId: parentId ?? this.parentId,
      parentName: parentName ?? this.parentName,
      pinyin: pinyin ?? this.pinyin,
      suffix: suffix ?? this.suffix,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'createdAt': createdAt,
      'distinctId': distinctId,
      'id': id,
      'initial': initial,
      'initials': initials,
      'isHot': isHot,
      'name': name,
      'parentCode': parentCode,
      'parentId': parentId,
      'parentName': parentName,
      'pinyin': pinyin,
      'suffix': suffix,
      'updatedAt': updatedAt,
    };
  }

  factory HotRegionListModel.fromMap(Map<String, dynamic> map) {
    return HotRegionListModel(
      code: map['code'] as String?,
      createdAt: map['createdAt'] as String?,
      distinctId: map['distinctId'] != null ? map['distinctId'] as int : null,
      id: map['id'] as String?,
      initial: map['initial'] as String?,
      initials: map['initials'] as String?,
      isHot: map['isHot'] as bool?,
      name: map['name'] as String?,
      parentCode: map['parentCode'] as String?,
      parentId: map['parentId'] != null ? map['parentId'] as int : null,
      parentName: map['parentName'] as String?,
      pinyin: map['pinyin'] as String?,
      suffix: map['suffix'] as String?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotRegionListModel.fromJson(String source) =>
      HotRegionListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HotRegionListModel(code: $code, createdAt: $createdAt, distinctId: $distinctId, id: $id, initial: $initial, initials: $initials, isHot: $isHot, name: $name, parentCode: $parentCode, parentId: $parentId, parentName: $parentName, pinyin: $pinyin, suffix: $suffix, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant HotRegionListModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.createdAt == createdAt &&
        other.distinctId == distinctId &&
        other.id == id &&
        other.initial == initial &&
        other.initials == initials &&
        other.isHot == isHot &&
        other.name == name &&
        other.parentCode == parentCode &&
        other.parentId == parentId &&
        other.parentName == parentName &&
        other.pinyin == pinyin &&
        other.suffix == suffix &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        createdAt.hashCode ^
        distinctId.hashCode ^
        id.hashCode ^
        initial.hashCode ^
        initials.hashCode ^
        isHot.hashCode ^
        name.hashCode ^
        parentCode.hashCode ^
        parentId.hashCode ^
        parentName.hashCode ^
        pinyin.hashCode ^
        suffix.hashCode ^
        updatedAt.hashCode;
  }
}
