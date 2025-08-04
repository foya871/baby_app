import 'dart:convert';
import 'package:flutter/foundation.dart';

class UnlockRecordModel {
  final List<BgImg>? bgImgs;
  final String? cityName;
  final String? coverImg;
  final String? logo;
  final int? meetUserId;
  final String? nickName;
  final String? unlockDate;
  final int? unlockGold;

  UnlockRecordModel({
    this.bgImgs,
    this.cityName,
    this.coverImg,
    this.logo,
    this.meetUserId,
    this.nickName,
    this.unlockDate,
    this.unlockGold,
  });

  UnlockRecordModel copyWith({
    List<BgImg>? bgImgs,
    String? cityName,
    String? coverImg,
    String? logo,
    int? meetUserId,
    String? nickName,
    String? unlockDate,
    int? unlockGold,
  }) {
    return UnlockRecordModel(
      bgImgs: bgImgs ?? this.bgImgs,
      cityName: cityName ?? this.cityName,
      coverImg: coverImg ?? this.coverImg,
      logo: logo ?? this.logo,
      meetUserId: meetUserId ?? this.meetUserId,
      nickName: nickName ?? this.nickName,
      unlockDate: unlockDate ?? this.unlockDate,
      unlockGold: unlockGold ?? this.unlockGold,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bgImgs': bgImgs?.map((x) => x.toMap()).toList(),
      'cityName': cityName,
      'coverImg': coverImg,
      'logo': logo,
      'meetUserId': meetUserId,
      'nickName': nickName,
      'unlockDate': unlockDate,
      'unlockGold': unlockGold,
    };
  }

  factory UnlockRecordModel.fromMap(Map<String, dynamic> map) {
    try {
      return UnlockRecordModel(
        bgImgs: map['bgImgs'] != null
            ? List<BgImg>.from(
                (map['bgImgs'] as List).map((x) => BgImg.fromMap(x)))
            : null,
        cityName: map['cityName'] as String?,
        coverImg: map['coverImg'] as String?,
        logo: map['logo'] as String?,
        meetUserId: map['meetUserId'] != null ? map['meetUserId'] as int : null,
        nickName: map['nickName'] as String?,
        unlockDate: map['unlockDate'] as String?,
        unlockGold: map['unlockGold'] != null ? map['unlockGold'] as int : null,
      );
    } catch (e) {
      return UnlockRecordModel.fromJson("source");
    }
  }

  String toJson() => json.encode(toMap());

  factory UnlockRecordModel.fromJson(String source) =>
      UnlockRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UnlockRecordModel(bgImgs: $bgImgs, cityName: $cityName, coverImg: $coverImg, logo: $logo, meetUserId: $meetUserId, nickName: $nickName, unlockDate: $unlockDate, unlockGold: $unlockGold)';
  }

  @override
  bool operator ==(covariant UnlockRecordModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.bgImgs, bgImgs) &&
        other.cityName == cityName &&
        other.coverImg == coverImg &&
        other.logo == logo &&
        other.meetUserId == meetUserId &&
        other.nickName == nickName &&
        other.unlockDate == unlockDate &&
        other.unlockGold == unlockGold;
  }

  @override
  int get hashCode {
    return bgImgs.hashCode ^
        cityName.hashCode ^
        coverImg.hashCode ^
        logo.hashCode ^
        meetUserId.hashCode ^
        nickName.hashCode ^
        unlockDate.hashCode ^
        unlockGold.hashCode;
  }
}

class BgImg {
  final String? authKey;
  final List<String>? coverImg;
  final String? fileId;
  final int? playTime;
  final int? size;
  final int? type;
  final String url;

  BgImg({
    this.authKey,
    this.coverImg,
    this.fileId,
    this.playTime,
    this.size,
    this.type,
    required this.url,
  });

  BgImg copyWith({
    String? authKey,
    List<String>? coverImg,
    String? fileId,
    int? playTime,
    int? size,
    int? type,
    String? url,
  }) {
    return BgImg(
      authKey: authKey ?? this.authKey,
      coverImg: coverImg ?? this.coverImg,
      fileId: fileId ?? this.fileId,
      playTime: playTime ?? this.playTime,
      size: size ?? this.size,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authKey': authKey,
      'coverImg': coverImg,
      'fileId': fileId,
      'playTime': playTime,
      'size': size,
      'type': type,
      'url': url,
    };
  }

  factory BgImg.fromMap(Map<String, dynamic> map) {
    try {
      return BgImg(
        authKey: map['authKey'] as String?,
        coverImg:
            map['coverImg'] != null ? List<String>.from(map['coverImg']) : null,
        fileId: map['fileId'] as String?,
        playTime: map['playTime'] != null ? map['playTime'] as int : null,
        size: map['size'] != null ? map['size'] as int : null,
        type: map['type'] != null ? map['type'] as int : null,
        url: map['url'] as String, // 仍然保持必选
      );
    } catch (e) {
      return BgImg.fromJson("");
    }
  }

  String toJson() => json.encode(toMap());

  factory BgImg.fromJson(String source) =>
      BgImg.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BgImg(authKey: $authKey, coverImg: $coverImg, fileId: $fileId, playTime: $playTime, size: $size, type: $type, url: $url)';
  }

  @override
  bool operator ==(covariant BgImg other) {
    if (identical(this, other)) return true;

    return other.authKey == authKey &&
        listEquals(other.coverImg, coverImg) &&
        other.fileId == fileId &&
        other.playTime == playTime &&
        other.size == size &&
        other.type == type &&
        other.url == url;
  }

  @override
  int get hashCode {
    return authKey.hashCode ^
        coverImg.hashCode ^
        fileId.hashCode ^
        playTime.hashCode ^
        size.hashCode ^
        type.hashCode ^
        url.hashCode;
  }
}
