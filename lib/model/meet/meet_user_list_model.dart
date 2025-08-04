import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:baby_app/model/meet/meet_user_detail_model.dart';

class MeetUserListModel {
  final int? age;
  final List<MeetUserBgImg> bgImgs;
  final String? bust;
  final String? cityName;
  final int? commentNum;
  final int? complaintNum;
  final String? coverImg;
  final String? createdAt;
  final List<String>? figure;
  final int? heightNum;
  final String? info;
  final int? lockNum;
  final String? logo;
  final int? meetUserId;
  final String? nickName;
  final int? nightPrice;
  final int? price;
  final String? priceDel;
  final String? reviewAt;
  final List<String>? serviceTags;
  final int? unlockGold;
  bool? unlocked;
  final String? updatedAt;

  int get ageInt => (age ?? 0) == 0 ? 16 : age!;

  MeetUserListModel({
    this.age,
    required this.bgImgs,
    this.bust,
    this.cityName,
    this.commentNum,
    this.complaintNum,
    this.coverImg,
    this.createdAt,
    this.figure,
    this.heightNum,
    this.info,
    this.lockNum,
    this.logo,
    this.meetUserId,
    this.nickName,
    this.nightPrice,
    this.price,
    this.priceDel,
    this.reviewAt,
    this.serviceTags,
    this.unlockGold,
    this.unlocked,
    this.updatedAt,
  });

  MeetUserListModel copyWith({
    int? age,
    required List<MeetUserBgImg> bgImgs,
    String? bust,
    String? cityName,
    int? commentNum,
    int? complaintNum,
    String? coverImg,
    String? createdAt,
    List<String>? figure,
    int? heightNum,
    String? info,
    int? lockNum,
    String? logo,
    int? meetUserId,
    String? nickName,
    int? nightPrice,
    int? price,
    String? priceDel,
    String? reviewAt,
    List<String>? serviceTags,
    int? unlockGold,
    bool? unlocked,
    String? updatedAt,
  }) {
    return MeetUserListModel(
      age: age ?? this.age,
      bgImgs: bgImgs,
      bust: bust ?? this.bust,
      cityName: cityName ?? this.cityName,
      commentNum: commentNum ?? this.commentNum,
      complaintNum: complaintNum ?? this.complaintNum,
      coverImg: coverImg ?? this.coverImg,
      createdAt: createdAt ?? this.createdAt,
      figure: figure ?? this.figure,
      heightNum: heightNum ?? this.heightNum,
      info: info ?? this.info,
      lockNum: lockNum ?? this.lockNum,
      logo: logo ?? this.logo,
      meetUserId: meetUserId ?? this.meetUserId,
      nickName: nickName ?? this.nickName,
      nightPrice: nightPrice ?? this.nightPrice,
      price: price ?? this.price,
      priceDel: priceDel ?? this.priceDel,
      reviewAt: reviewAt ?? this.reviewAt,
      serviceTags: serviceTags ?? this.serviceTags,
      unlockGold: unlockGold ?? this.unlockGold,
      unlocked: unlocked ?? this.unlocked,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'bgImgs': bgImgs.map((x) => x.toMap()).toList(),
      'bust': bust,
      'cityName': cityName,
      'commentNum': commentNum,
      'complaintNum': complaintNum,
      'coverImg': coverImg,
      'createdAt': createdAt,
      'figure': figure,
      'heightNum': heightNum,
      'info': info,
      'lockNum': lockNum,
      'logo': logo,
      'meetUserId': meetUserId,
      'nickName': nickName,
      'nightPrice': nightPrice,
      'price': price,
      'priceDel': priceDel,
      'reviewAt': reviewAt,
      'serviceTags': serviceTags,
      'unlockGold': unlockGold,
      'unlocked': unlocked,
      'updatedAt': updatedAt,
    };
  }

  factory MeetUserListModel.fromMap(Map<String, dynamic> map) {
    return MeetUserListModel(
      age: map['age'] as int?,
      bgImgs: map['bgImgs'] != null
          ? List<MeetUserBgImg>.from(
              (map['bgImgs'] as List).map((x) => MeetUserBgImg.fromMap(x)))
          : [],
      bust: map['bust'] as String?,
      cityName: map['cityName'] as String?,
      commentNum: map['commentNum'] as int?,
      complaintNum: map['complaintNum'] as int?,
      coverImg: map['coverImg'] as String?,
      createdAt: map['createdAt'] as String?,
      figure: map['figure'] != null
          ? List<String>.from(map['figure'] as List)
          : null,
      heightNum: map['heightNum'] as int?,
      info: map['info'] as String?,
      lockNum: map['lockNum'] as int?,
      logo: map['logo'] as String?,
      meetUserId: map['meetUserId'] as int?,
      nickName: map['nickName'] as String?,
      nightPrice: map['nightPrice'] as int?,
      price: map['price'] as int?,
      priceDel: map['priceDel'] as String?,
      reviewAt: map['reviewAt'] as String?,
      serviceTags: map['serviceTags'] != null
          ? List<String>.from(map['serviceTags'] as List)
          : null,
      unlockGold: map['unlockGold'] as int?,
      unlocked: map['unlocked'] as bool?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetUserListModel.fromJson(String source) =>
      MeetUserListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MeetUserListModel(age: $age, bgImgs: $bgImgs, bust: $bust, cityName: $cityName, commentNum: $commentNum, complaintNum: $complaintNum, coverImg: $coverImg, createdAt: $createdAt, figure: $figure, heightNum: $heightNum, info: $info, lockNum: $lockNum, logo: $logo, meetUserId: $meetUserId, nickName: $nickName, nightPrice: $nightPrice, price: $price, priceDel: $priceDel, reviewAt: $reviewAt, serviceTags: $serviceTags, unlockGold: $unlockGold, unlocked: $unlocked, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant MeetUserListModel other) {
    if (identical(this, other)) return true;

    return other.age == age &&
        listEquals(other.bgImgs, bgImgs) &&
        other.bust == bust &&
        other.cityName == cityName &&
        other.commentNum == commentNum &&
        other.complaintNum == complaintNum &&
        other.coverImg == coverImg &&
        other.createdAt == createdAt &&
        listEquals(other.figure, figure) &&
        other.heightNum == heightNum &&
        other.info == info &&
        other.lockNum == lockNum &&
        other.logo == logo &&
        other.meetUserId == meetUserId &&
        other.nickName == nickName &&
        other.nightPrice == nightPrice &&
        other.price == price &&
        other.priceDel == priceDel &&
        other.reviewAt == reviewAt &&
        listEquals(other.serviceTags, serviceTags) &&
        other.unlockGold == unlockGold &&
        other.unlocked == unlocked &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return age.hashCode ^
        bgImgs.hashCode ^
        bust.hashCode ^
        cityName.hashCode ^
        commentNum.hashCode ^
        complaintNum.hashCode ^
        coverImg.hashCode ^
        createdAt.hashCode ^
        figure.hashCode ^
        heightNum.hashCode ^
        info.hashCode ^
        lockNum.hashCode ^
        logo.hashCode ^
        meetUserId.hashCode ^
        nickName.hashCode ^
        nightPrice.hashCode ^
        price.hashCode ^
        priceDel.hashCode ^
        reviewAt.hashCode ^
        serviceTags.hashCode ^
        unlockGold.hashCode ^
        unlocked.hashCode ^
        updatedAt.hashCode;
  }
}
